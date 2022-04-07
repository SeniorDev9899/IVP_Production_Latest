<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use JWTAuth;
use Tymon\JWTAuth\Exceptions\JWTException;
use Illuminate\Support\Facades\Hash;
// use App\Mail\WelcomeMail;
use App\User;
use SendGrid;

class AuthController extends Controller
{
    public function store(Request $request)
    {
        $this->validate($request, [
            'first_name' => 'required',
            'last_name' => 'required',            
            'gender' => 'required',
            'email' => 'required|email',
            'password' => 'required'
        ]);

        $user = User::create([
            'first_name' => $request->first_name, 
            'last_name' => $request->last_name,
            'email' => $request->email, 
            'password' => Hash::make($request->password),
            'gender' => $request->gender, 
        ]);
        $email = new \SendGrid\Mail\Mail();
        $email->setFrom(env('SENDGRID_FROM'), "IVP");
        $email->addTo($request->email);
        $email->setTemplateId(
            new \SendGrid\Mail\TemplateId( env('EMAIL_TEMPLATE_ID') )
        );
        $email->addDynamicTemplateDatas( [
            'name'     => $request->first_name . "" . $request->last_name,
            'link' => env('PRODUCTION_MODE') . "login?email=" . $request->email . "&email_verification=true"
        ]);

        $sendgrid = new \SendGrid(env('SENDGRID_API_KEY'));
        $sendgrid->send($email);

        if(!$user->role)
        {               
            return response()->json([
                'first_name' => $user->first_name,
                'last_name' => $user->last_name,
                'gender' => $user->gender,
                'email' => $user->email,
                'role' => 'practitioner',
                'email_verification_status' => 0
            ]);
        } else {
            return response()->json([
                'first_name' => $user->first_name,
                'last_name' => $user->last_name,
                'gender' => $user->gender,
                'email' => $user->email,
                'role' => $user->role,
                'email_verification_status' => 0
            ]);
        }
        
    }

    public function resendEmailVerification(Request $request) {
        $email = new \SendGrid\Mail\Mail();
        $email->setFrom(env('SENDGRID_FROM'), "IVP");
        $email->addTo($request->email);
        $email->setTemplateId(
            new \SendGrid\Mail\TemplateId( env('EMAIL_TEMPLATE_ID') )
        );
        $email->addDynamicTemplateDatas( [
            'name'     => $request->first_name . "" . $request->last_name,
            'link' => env('PRODUCTION_MODE') . "login?email=" . $request->email . "&email_verification=true"
        ]);

        $sendgrid = new \SendGrid(env('SENDGRID_API_KEY'));
        $sendgrid->send($email);

        return "Email has been resent";
    }

    public function passwordReset(Request $request) {
        $user = User::where('email',$request->email)->first();
        $email = new \SendGrid\Mail\Mail();
        $email->setFrom(env('SENDGRID_FROM'), "IVP");
        $email->addTo($request->email);
        $email->setTemplateId(
            new \SendGrid\Mail\TemplateId( env('PASS_RESET_EMAIL_TEMPLATE_ID') )
        );
        $email->addDynamicTemplateDatas( [
            'link' => env('PRODUCTION_MODE') . "reset-form?user_id=" . $user->id
        ]);

        $sendgrid = new \SendGrid(env('SENDGRID_API_KEY'));
        $sendgrid->send($email);

        return "Email has been resent for password reset";
    }

    public function updateUserPasswordWithId(Request $request, $id) {
        $this->validate($request, [
            'new_password' => 'required',
            'confirm_password' => 'required',
        ]);
        if($request->new_password == $request->confirm_password) {
            return User::where('id',$id)->update([
                'password' => Hash::make($request->new_password),
            ]);
        } else {
            return 2;
        }
    }

    public function newMemberAdd(Request $request) {
        $this->validate($request, [
            'first_name' => 'required',
            'last_name' => 'required',            
            'gender' => 'required',
            'email' => 'required|email',
            'password' => 'required',
            'role' => 'required',
            'region' => 'required'
        ]);

        $user = User::create([
            'first_name' => $request->first_name, 
            'last_name' => $request->last_name,
            'email' => $request->email, 
            'password' => Hash::make($request->password),
            'gender' => $request->gender, 
            'role' => $request->role,
            'region' => $request->region
        ]);
        return $user;
    }

    public function authenticate(Request $request)
    {
        // grab credentials from the request
        $credentials = $request->only('email', 'password');
        try {
            // attempt to verify the credentials and create a token for the user
            if (! $token = JWTAuth::attempt($credentials)) {
                return response()->json(['error' => 'invalid_credentials'], 401);
            }
        } catch (JWTException $e) {
            // something went wrong whilst attempting to encode the token
            return response()->json(['error' => 'could_not_create_token'], 500);
        }

        $user = User::where('email',$request->email)->get();

        // all good so return the token
        return response()->json([
            'token' => compact('token'),
            'user_data' => $user
        ]);
    }

    public function check()
    {
        try {
            JWTAuth::parseToken()->authenticate();
        } catch (JWTException $e) {
            return response(['authenticated' => false]);
        }
        return response(['authenticated' => true]);
    }

    public function updateUserEmailVerification(Request $request) {
        return User::where('email',$request->verified_email)->update([
            'email_verification_status' => $request->verification
        ]);
    }

    public function logout()
    {
        try {
            $token = JWTAuth::getToken();

            if ($token) {
                JWTAuth::invalidate($token);
            }

        } catch (JWTException $e) {
            return response()->json($e->getMessage(), 401);
        }
        return response()->json(['message' => 'Log out success'], 200);
    }
}
