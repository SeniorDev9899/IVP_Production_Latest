<template>
  <div>
    <header class="site-header">
      <a href="#" class="brand-main">
        <img
          id="logo-desk"
          src="/assets/img/logo.png"
          alt="Identity Verification Portal"
          class="d-none d-md-inline"
        />
        <img
          id="logo-mobile"
          src="/assets/img/logo.png"
          alt="Identity Verification Portal"
          class="d-md-none"
        />
        <span class="d-none d-md-inline title">{{ $t("header.title") }}</span>
        <span class="d-md-none title">{{ $t("header.mobile.title") }}</span>
      </a>
      <a href="#" class="nav-toggle" @click="onNavToggle">
        <div class="hamburger hamburger--arrowturn">
          <div class="hamburger-box">
            <div class="hamburger-inner" />
          </div>
        </div>
      </a>
      <ul class="action-list">
        <li>
          <vue-country-code
            @onSelect="onSelect"
            :dropdownOptions="{
              disabledDialCode: true,
            }"
            :onlyCountries="['cn', 'us']"
            :defaultCountry="getCountry"
            id="country-select"
          >
          </vue-country-code>
        </li>
        <li v-if="user_role == 'admin' || user_role == 'sub_admin'">
          <v-dropdown :show-arrow="false">
            <a slot="activator" href="#">
              <i class="icon-fa icon-fa-plus" />
            </a>
          </v-dropdown>
        </li>
        <li v-if="user_role == 'admin' || user_role == 'sub_admin'">
          <v-dropdown :show-arrow="false">
            <a
              slot="activator"
              href="#"
              data-toggle="dropdown"
              aria-haspopup="true"
              aria-expanded="false"
            >
              <i class="icon-fa icon-fa-bell" />
            </a>
          </v-dropdown>
        </li>
        <li>
          <v-dropdown :show-arrow="false" class="user-avatar">
            <a
              slot="activator"
              href="#"
              data-toggle="dropdown"
              aria-haspopup="true"
              aria-expanded="false"
              class="avatar"
            >
              <img :src="user_picture" alt="Avatar" />
            </a>
            <v-dropdown-item>
              <router-link
                class="dropdown-item"
                :to="'/admin/users/profile/' + user_id"
              >
                <i class="fa fa-user" aria-hidden="true"></i>
                {{ $t("header.user.profile") }}
              </router-link>
            </v-dropdown-item>
            <v-dropdown-item>
              <a href="#" class="dropdown-item" @click.prevent="logout">
                <i class="icon-fa icon-fa-sign-out" />
                {{ $t("header.user.logout") }}
              </a>
            </v-dropdown-item>
          </v-dropdown>
        </li>
      </ul>
    </header>

    <div
      class="email_verification_notification"
      :class="notificationStatus == true ? 'verified' : 'not_verified'"
    >
      <div v-if="email_verification_status == 0" class="error">
        <div v-if="notificationStatus == false">
          <span>{{ $t("header.email_verification.notVerified") }}</span
          ><button class="resend_email" @click="resendEmail">
            {{ $t("header.email_verification.resend") }}
          </button>
        </div>
      </div>
      <div v-else class="success">
        <div v-if="notificationStatus == false">
          <span>{{ $t("header.email_verification.verified") }}</span>
        </div>
      </div>
      <div class="close_notification" v-if="notificationStatus == false">
        <button @click="closeNotification">X</button>
      </div>
    </div>
  </div>
</template>
<script type="text/babel">
import Auth from "../../../services/auth";
import Ls from "./../../../services/ls.js";
export default {
  props: ["user_avatar"],
  data() {
    return {
      user_role: "",
      user_id: "",
      user_picture: "/assets/img/default-user-avatar.jpg",
      email_verification_status: null,
      notificationStatus: false,
    };
  },
  watch: {
    user_avatar: function (newVal, oldVal) {
      this.user_picture = newVal;
    },
  },
  async created() {
    this.user_role = Ls.get("Role");
    this.user_id = Ls.get("user_id");
    this.user_picture = "/assets/img/default-user-avatar.jpg";
    try {
      const response = await axios.get(
        `/api/admin/user/avatar/get/${this.user_id}`
      );
      if (response.data.length !== 0) {
        Ls.set("user_avatar", response.data);
        this.user_picture = Ls.get("user_avatar");
      }
    } catch (err) {
      if (this.$i18n.locale == "en") {
        window.toastr["error"]("There was an error", "Error");
      } else if (this.$i18n.locale == "ch") {
        window.toastr["error"]("有一個錯誤", "錯誤");
      }
    }
    this.email_verification_status = Ls.get("email_verification_status");
  },
  computed: {
    getCountry() {
      return Ls.get("countryLang");
    },
  },
  methods: {
    onNavToggle() {
      this.$utils.toggleSidebar();
    },
    logout() {
      Auth.logout(this.$i18n.locale).then(() => {
        this.$router.replace("/login");
      });
    },
    onSelect({ name, iso2, dialCode }) {
      if (iso2.toString() == "US") {
        this.$i18n.locale = "en";
        Ls.set("countryLang", iso2.toString());
        this.$emit("changeLang", this.$i18n.locale);
      } else if (iso2.toString() == "CN") {
        this.$i18n.locale = "ch";
        Ls.set("countryLang", iso2.toString());
        this.$emit("changeLang", this.$i18n.locale);
      }
    },
    closeNotification() {
      this.notificationStatus = true;
    },
    resendEmail() {
      let resendEmailData = {
        first_name: Ls.get("First Name"),
        last_name: Ls.get("Last Name"),
        email: Ls.get("Email"),
      };
      let locale = Ls.get("countryLang");
      Auth.resendEmailVerification(resendEmailData, locale).then((res) => {
        var today = new Date();
        var date =
          today.getFullYear() +
          "-" +
          (today.getMonth() + 1) +
          "-" +
          today.getDate();
        var time =
          today.getHours() +
          ":" +
          today.getMinutes() +
          ":" +
          today.getSeconds();
        let info = {
          time: date + " " + time,
          type: "email_verification",
          result: true,
        };
        let keepUserInfo = JSON.stringify(info);
        Auth.keepRemarkInformation(this.user_id, {
          info: keepUserInfo,
        }).then((res) => {});
      });
    },
  },
};
</script>

<style scoped>
.action-list li {
  border-radius: 20px;
  background: transparent;
}
.action-list .dropdown-group {
  background-color: transparent;
}
.action-list .avatar img {
  width: 41px;
  border-radius: 20px;
}
.brand-main img {
  height: 40px;
  padding-top: 0px;
}
.title {
  font-size: 20px;
  font-family: "Roboto";
  color: #5c5959;
  font-weight: bold;
}
.user-avatar {
  height: 100%;
}
.user-avatar .avatar {
  height: 100%;
  border-radius: 20px;
}
.user-avatar .avatar img {
  max-height: 100%;
  height: 36px;
}
.email_verification_notification {
  text-align: center;
  z-index: 2;
  width: 100%;
  position: fixed;
  top: 60px;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: ease 0.5s all;
}
.success {
  background-color: rgb(174 246 253);
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
}
.error {
  background-color: rgb(233 95 59);
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
}
.not_verified {
  height: 60px;
}
.verified {
  height: 0px;
}
.close_notification {
  position: absolute !important;
  right: 15px;
}
.close_notification button {
  background-color: transparent !important;
  border: 1px solid #878282 !important;
  border-radius: 10px !important;
  color: #878282;
  transition: ease 0.5s all;
}
.close_notification button:hover {
  color: #140a0a;
  border: 1px solid #140a0a !important;
}
</style>

<style>
.user-avatar .dropdown-activator {
  height: 100% !important;
}
#country-select {
  position: relative;
  left: 0px !important;
  top: 0px !important;
}
#country-select {
  border: 1px solid rgb(205 191 102) !important;
}
#country-select .dropdown:hover {
  background-color: rgb(221 204 52) !important;
}
#country-select .current .iti-flag {
  margin-right: 5px;
}
#country-select .dropdown-list {
  width: 200px !important;
  z-index: 3;
}
.resend_email {
  background-color: rgb(255 222 0);
  border: rgb(255 222 0) 1px solid;
  border-radius: 15px;
  margin-left: 15px;
  font-weight: 400;
  padding: 0px 10px;
}
.resend_email:hover {
  background-color: rgb(253 230 76);
  border: rgb(253 230 76) 1px solid;
}
</style>