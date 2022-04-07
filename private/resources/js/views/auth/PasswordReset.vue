<template>
  <div class="password-reset">
    <form @submit.prevent="passwordReset">
      <h3>{{ $t("forgot_password.title") }}</h3>
      <div class="form-group">
        <label>{{ $t("forgot_password.email") }}</label>
        <input
          type="email"
          class="form-control form-control-lg"
          v-model="email"
        />
      </div>
      <button type="submit" class="btn btn-theme btn-full">
        <span v-if="loadingPage == false">{{
          $t("forgot_password.reset_password")
        }}</span>
        <clip-loader :loading="loadingPage"></clip-loader>
      </button>
    </form>
  </div>
</template>
<script>
import Auth from "./../../services/auth";
import Ls from "./../../services/ls";
import ClipLoader from "vue-spinner/src/ClipLoader.vue";
export default {
  data() {
    return {
      email: "",
      loadingPage: false,
    };
  },
  mounted() {
    this.loadingPage = false;
  },
  components: {
    ClipLoader,
  },
  methods: {
    passwordReset() {
      this.loadingPage = true;
      let resetPasswordData = {
        email: this.email,
      };
      let locale = Ls.get("countryLang");
      Auth.passwordReset(resetPasswordData, locale).then((res) => {
        this.loadingPage = false;
      });
    },
  },
};
</script>
<style scoped>
.password-reset {
  margin-top: 30px;
}
.password-reset h3 {
  color: white;
  text-align: center;
}
.password-reset button {
  margin-top: 25px;
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
.v-spinner {
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>