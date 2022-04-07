<template>
  <div>
    <form @submit.prevent="validateBeforeSubmit">
      <div class="user-registration-first-last-name">
        <div
          :class="[
            'form-group name-form',
            { 'is-invalid': $v.registerData.first_name.$error },
          ]"
        >
          <label for="signup-fist-name">{{ $t("register.first_name") }}</label>
          <input
            :class="{
              'is-invalid': $v.registerData.first_name.$error,
              'form-group--loading': $v.registerData.first_name.$pending,
            }"
            v-model.lazy="registerData.first_name"
            class="form-control"
            :placeholder="$t('register.placeholder.input_first_name')"
            type="text"
            id="signup-fist-name"
            @change="$v.registerData.first_name.$touch()"
          />
          <span
            v-if="!$v.registerData.first_name.required"
            class="invalid-feedback"
          >
            {{ $t("register.validation.first_name_required") }}
          </span>
          <span
            v-if="!$v.registerData.first_name.minLength"
            class="invalid-feedback"
          >
            {{ $t("register.validation.first_name_least") }}
            {{ $v.registerData.first_name.$params.minLength.min }}
            {{ $t("register.validation.letters") }}.
          </span>
        </div>
        <div
          :class="[
            'form-group name-form',
            { 'is-invalid': $v.registerData.last_name.$error },
          ]"
        >
          <label for="signup-last-name">{{ $t("register.last_name") }}</label>
          <input
            :class="{
              'is-invalid': $v.registerData.last_name.$error,
              'form-group--loading': $v.registerData.last_name.$pending,
            }"
            v-model.lazy="registerData.last_name"
            class="form-control"
            :placeholder="$t('register.placeholder.input_last_name')"
            type="text"
            id="signup-last-name"
            @change="$v.registerData.last_name.$touch()"
          />
          <span
            v-if="!$v.registerData.last_name.required"
            class="invalid-feedback"
          >
            {{ $t("register.validation.last_name_required") }}
          </span>
          <span
            v-if="!$v.registerData.last_name.minLength"
            class="invalid-feedback"
          >
            {{ $t("register.validation.last_name_least") }}
            {{ $v.registerData.last_name.$params.minLength.min }}
            {{ $t("register.validation.letters") }}.
          </span>
        </div>
      </div>
      <div
        :class="['form-group', { 'is-invalid': $v.registerData.email.$error }]"
      >
        <label for="signup-email">{{ $t("register.email") }}</label>
        <input
          :class="{
            'is-invalid': $v.registerData.email.$error,
            'form-group--loading': $v.registerData.email.$pending,
          }"
          v-model.trim.lazy="registerData.email"
          class="form-control"
          :placeholder="$t('register.placeholder.input_email')"
          type="email"
          id="signup-email"
          @change="$v.registerData.email.$touch()"
        />
        <span v-if="!$v.registerData.email.required" class="invalid-feedback">
          {{ $t("register.validation.email_required") }}
        </span>
        <span v-if="!$v.registerData.email.email" class="invalid-feedback">
          {{ $t("register.validation.email_verify") }}.
        </span>
        <span v-if="!$v.registerData.email.isUnique" class="invalid-feedback">
          {{ $t("register.validation.email_already") }}.
        </span>
      </div>
      <div
        :class="[
          'form-group',
          { 'is-invalid': $v.registerData.password.$error },
        ]"
      >
        <label for="signup-password">{{ $t("register.password") }}</label>
        <input
          :class="{ 'is-invalid': $v.registerData.password.$error }"
          v-model.trim="registerData.password"
          class="form-control"
          :placeholder="$t('register.placeholder.input_password')"
          type="password"
          id="signup-password"
          @change="$v.registerData.password.$touch()"
        />
        <span
          v-if="!$v.registerData.password.required"
          class="invalid-feedback"
        >
          {{ $t("register.validation.password_required") }}.
        </span>
        <span
          v-if="!$v.registerData.password.minLength"
          class="invalid-feedback"
        >
          {{ $t("register.validation.password_least") }}
          {{ $v.registerData.password.$params.minLength.min }}
          {{ $t("register.validation.letters") }}.
        </span>
      </div>
      <div
        :class="[
          'form-group',
          { 'is-invalid': $v.registerData.password_confirmation.$error },
        ]"
      >
        <label for="signup-confirm-password">{{
          $t("register.confirm_password")
        }}</label>
        <input
          :class="{
            'is-invalid': $v.registerData.password_confirmation.$error,
          }"
          v-model.trim="registerData.password_confirmation"
          class="form-control"
          :placeholder="$t('register.placeholder.retype_password')"
          id="signup-confirm-password"
          type="password"
          @change="$v.registerData.password_confirmation.$touch()"
        />
        <span
          v-if="!$v.registerData.password_confirmation.sameAsPassword"
          class="invalid-feedback"
        >
          {{ $t("register.validation.password_identical") }}
        </span>
      </div>
      <div class="form-group">
        <label for="gender">{{ $t("register.gender") }}</label>
        <div
          class="form-group margin-top-0"
          :class="{ 'is-invalid': $v.registerData.gender.$error }"
        >
          <div
            class="form-check form-check-inline"
            :class="{
              'is-invalid': $v.registerData.gender.$error,
            }"
          >
            <input
              class="form-check-input"
              type="radio"
              name="gender"
              v-model="registerData.gender"
              id="gender1"
              value="male"
            />
            <label class="form-check-label" for="gender1">{{
              $t("register.male")
            }}</label>
          </div>
          <div
            class="form-check form-check-inline"
            :class="{
              'is-invalid': $v.registerData.gender.$error,
            }"
          >
            <input
              class="form-check-input"
              type="radio"
              name="gender"
              v-model="registerData.gender"
              id="gender2"
              value="female"
            />
            <label class="form-check-label" for="gender2">{{
              $t("register.female")
            }}</label>
          </div>
          <div v-if="$v.registerData.gender.$error" class="invalid-feedback">
            <span v-if="!$v.registerData.gender.required">{{
              $t("register.valiation.gender_required")
            }}</span>
          </div>
        </div>
      </div>
      <div class="form-group">
        <div
          class="form-group margin-top-0"
          :class="{ 'is-invalid': $v.registerData.terms.$error }"
        >
          <div
            class="form-check form-check-inline"
            :class="{
              'is-invalid': $v.registerData.terms.$error,
            }"
          >
            <input
              class="form-check-input"
              type="checkbox"
              name="terms"
              v-model="registerData.terms"
              id="terms"
            />
          </div>
          <label class="form-check-label" for="terms"
            >{{ $t("register.accept")
            }}<a href="#">{{ $t("register.terms_condition") }}</a></label
          >
          <div
            v-if="$v.registerData.terms.$error"
            class="invalid-feedback terms_conditions"
          >
            <span v-if="!$v.registerData.terms.required">{{
              $t("register.terms_condition_required")
            }}</span>
          </div>
        </div>
      </div>
      <button class="btn btn-login btn-full">
        <span v-if="loadingPage == false">{{ $t("register.register") }}</span>
        <clip-loader :loading="loadingPage"></clip-loader>
      </button>
      <div class="ivp-to-login">
        <span>{{ $t("register.already_account") }}</span>
        <router-link to="/login">{{ $t("register.sign_in") }}</router-link>
      </div>
    </form>
  </div>
</template>
<script>
import Auth from "../../services/auth";
import { required, minLength, email, sameAs } from "vuelidate/lib/validators";
import ClipLoader from "vue-spinner/src/ClipLoader.vue";

export default {
  name: "register",
  data() {
    return {
      registerData: {
        first_name: "Alex",
        last_name: "Rossi",
        email: "",
        password: "",
        password_confirmation: "",
        gender: "male",
        terms: true,
      },
      loadingPage: false,
      validateCaptcha: false,
    };
  },
  mounted() {
    this.loadingPage = false;
  },
  validations: {
    registerData: {
      first_name: {
        required,
        minLength: minLength(3),
      },
      last_name: {
        required,
        minLength: minLength(3),
      },
      password: {
        required,
        minLength: minLength(6),
      },
      password_confirmation: {
        sameAsPassword: sameAs("password"),
      },
      email: {
        required,
        email,
        async isUnique(value) {
          // standalone validator ideally should not assume a field is required
          if (value === "") return true;

          // simulate async call, fail for all logins with even length
          let response = await window.axios.post("/api/email-exist", {
            email: value,
          });
          return response.data;
        },
      },
      gender: {
        required,
      },
      terms: {
        required,
      },
    },
  },
  components: {
    ClipLoader,
  },
  methods: {
    validateBeforeSubmit() {
      this.loadingPage = true;
      this.$v.$touch();
      if (!this.$v.$error) {
        this.register(this.$i18n.locale);
      }
    },
    register(locale) {
      Auth.register(this.registerData, locale).then((res) => {
        if (res) {
          this.loadingPage = false;
          this.$router.push("/email_verification");
        }
      });
    },
  },
};
</script>

<style scoped>
.form-group {
  position: relative;
  margin-top: 30px;
}
.form-group label {
  margin: 0px;
  margin-bottom: 5px;
}
.login-page .login-box .form-control {
  margin: 0px;
}
.ivp-to-login {
  margin-top: 30px;
  display: flex;
  align-items: center;
  justify-content: center;
}
.ivp-to-login span {
  margin-right: 10px;
}
.invalid-feedback {
  position: absolute;
  top: 75px;
  text-align: center;
}
.btn-login {
  margin-top: 15px;
}
.margin-top-0 {
  margin-top: 0px;
  display: flex;
  align-items: center;
}
.margin-top-0 label {
  margin: 0px !important;
}
.margin-top-0 div {
  margin-right: 5px;
}
.user-registration-first-last-name {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-top: 30px;
}
.user-registration-first-last-name .form-group {
  width: 48%;
}
.terms_conditions {
  top: 20px !important;
}
.name-form {
  margin: 0px;
}
.v-spinner {
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>
