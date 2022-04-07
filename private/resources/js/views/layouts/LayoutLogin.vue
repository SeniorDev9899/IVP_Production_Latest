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

        <h1>{{ $t("title") }}</h1>
        <router-view />
      </div>
    </div>
  </div>
</template>

<script>
import Ls from "./../../services/ls";
export default {
  computed: {
    getCountry() {
      if (Ls.get("countryLang") != null) {
        return Ls.get("countryLang");
      } else {
        return "CN";
      }
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
</style>
