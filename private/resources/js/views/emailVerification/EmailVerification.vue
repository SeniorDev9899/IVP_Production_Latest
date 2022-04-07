<template>
  <div class="login-page login-1" id="login-1">
    <div class="language-select">
      <vue-country-code
        @onSelect="onSelect"
        :dropdownOptions="{
          disabledDialCode: true,
        }"
        :onlyCountries="['cn', 'us']"
        :defaultCountry="getCountry"
      >
      </vue-country-code>
    </div>
    <div class="login-wrapper">
      <div class="login-box">
        <div class="logo-main">
          <a href="/admin">
            <img src="/assets/img/logo.png" alt="Laraspace Logo" />
          </a>
        </div>

        <h1>{{ $t("emailVerification.title") }}</h1>
        <div>
          <div class="context">
            <p>
              {{ $t("emailVerification.sent") }}
              <span style="font-weight: bold">{{ getRegisteredEmail }}</span>
            </p>
            <p>{{ $t("emailVerification.continue") }}</p>
            <span>{{ $t("emailVerification.context") }} </span>
          </div>
          <div class="resend_verification">
            <button class="btn btn-theme btn-full" @click="resendEmail">
              <span v-if="loadingPage == false">{{
                $t("emailVerification.resend")
              }}</span>
              <clip-loader :loading="loadingPage"></clip-loader>
            </button>
          </div>
          <div class="back-to-signin">
            <router-link to="/login">{{
              $t("emailVerification.backToSignIn")
            }}</router-link>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Auth from "./../../services/auth";
import Ls from "./../../services/ls";
import ClipLoader from "vue-spinner/src/ClipLoader.vue";
export default {
  data() {
    return {
      loadingPage: false,
    };
  },
  mounted() {
    this.loadingPage = false;
  },
  components: {
    ClipLoader,
  },
  computed: {
    getCountry() {
      if (Ls.get("countryLang") != null) {
        return Ls.get("countryLang");
      } else {
        return "CN";
      }
    },
    getRegisteredEmail() {
      return Ls.get("Email");
    },
  },
  methods: {
    onSelect({ name, iso2, dialCode }) {
      if (iso2.toString() == "US") {
        this.$i18n.locale = "en";
        Ls.set("countryLang", iso2.toString());
      } else if (iso2.toString() == "CN") {
        this.$i18n.locale = "ch";
        Ls.set("countryLang", iso2.toString());
      }
    },
    resendEmail() {
      this.loadingPage = true;
      let resendEmailData = {
        first_name: Ls.get("First Name"),
        last_name: Ls.get("Last Name"),
        email: Ls.get("Email"),
      };
      let locale = Ls.get("countryLang");
      Auth.resendEmailVerification(resendEmailData, locale).then((res) => {
        this.loadingPage = false;
      });
    },
  },
};
</script>

<style scoped>
.login-page .logo-main img {
  height: auto;
  width: 120px;
}
.login-page .login-box {
  color: #fff;
  padding: 20px;
  width: 100%;
  max-width: 600px;
}
.login-page .login-box h1 {
  color: white;
  text-align: center;
}
.language-select {
  position: relative;
}
</style>

<style>
.btn-theme {
  color: #212529;
  background-color: #ffde00;
  border-color: #ffde00;
  -o-box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.15),
    0 1px 1px rgba(0, 0, 0, 0.075);
  -ms-box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.15),
    0 1px 1px rgba(0, 0, 0, 0.075);
  -webkit-box-shadow: inset 0 1px 0 rgb(255 255 255 / 15%),
    0 1px 1px rgb(0 0 0 / 8%);
  box-shadow: inset 0 1px 0 rgb(255 255 255 / 15%), 0 1px 1px rgb(0 0 0 / 8%);
}
.toast-success {
  /* background-color: #51a351; */
  background-color: #51a351 !important;
}
.toast-info {
  background-color: #2f96b4;
}
.toast-error {
  background-color: #bd362f !important;
}
.vue-country-select {
  position: relative;
  left: calc(100% - 190px) !important;
  top: 15px !important;
  border: 1px solid rgb(116 102 108) !important;
}
.vue-country-select .dropdown:hover {
  background-color: rgb(100, 100, 100) !important;
}
.current .iti-flag {
  margin-right: 5px;
}
.dropdown-list {
  width: 180px !important;
}
.context {
  margin: 0px auto;
  max-width: 510px;
  text-align: center;
  margin-top: 35px;
  margin-bottom: 40px;
}
.context p {
  font-size: 20px;
}
.back-to-signin {
  text-align: center;
  margin-top: 30px;
}
.v-spinner {
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>
