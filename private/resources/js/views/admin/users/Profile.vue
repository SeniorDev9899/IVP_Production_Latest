<template>
  <div
    class="page-profile"
    :class="
      current_user_role == 'practitioner' || toggle == true
        ? 'role_practitioner'
        : 'main-content'
    "
  >
    <!-- :class="user_role == 'practitioner' ? 'role_practitioner' : 'main-content'" -->
    <div class="page-header">
      <h3 class="page-title">{{ $t("profile.user_profile") }}</h3>
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="#">{{ $t("profile.home") }}</a>
        </li>
        <li class="breadcrumb-item">
          <a href="/admin/users/all">{{ $t("profile.users") }}</a>
        </li>
        <li class="breadcrumb-item active">
          {{ user_first_name }} {{ user_last_name }}
        </li>
      </ol>
    </div>
    <div
      v-if="current_user_verification_status == 'nonactivated'"
      class="row member-verification"
    >
      <button
        class="btn btn-warning btn-rounded"
        @click="startMemberVerification"
      >
        <div class="verification-icon">
          <i class="fa-solid fa-user-check"></i>
        </div>
        <span>{{ $t("profile.start_verification") }}</span>
      </button>
    </div>
    <div>
      <b-tabs
        active-nav-item-class="text-uppercase text-warning"
        content-class="mt-3"
      >
        <b-tab :title="$t('profile.edit_profile')" active>
          <div class="row">
            <div class="col-sm-12">
              <div class="card">
                <div class="card-body">
                  <tabs class="tabs-default">
                    <div class="row">
                      <div class="col-sm-2">
                        <div class="avatar-container">
                          <img
                            :src="user_picture"
                            alt="Admin Avatar"
                            class="img-fluid"
                          />
                          <form
                            @submit="changeUserAvatar"
                            enctype="multipart/form-data"
                          >
                            <input
                              id="user-avatar"
                              type="file"
                              accept="image/png, image/gif, image/jpeg"
                              class="form-control"
                              v-on:change="onChange"
                              style="display: none"
                            />
                            <button
                              type="submit"
                              class="btn btn-primary btn-block"
                              style="display: none"
                            ></button>
                            <button
                              @click="changeAvatarOccurr"
                              v-tooltip="{
                                content: tooltipText,
                                placement: position + '-center',
                                delay: {
                                  show: 200,
                                  hide: 300,
                                },
                                classes: ['info'],
                              }"
                              class="user-avatar-change"
                            ></button>
                          </form>
                        </div>
                        <div class="personal-info"></div>
                      </div>
                      <div class="col-sm-10">
                        <h2>{{ $t("profile.edit_profile") }}</h2>
                        <div class="edit-personal-profile">
                          <b-form @submit.stop.prevent="onSubmit">
                            <div class="user-name-edit">
                              <b-form-group
                                id="first-name-input-group"
                                :label="$t('profile.first_name')"
                                label-for="first-name-input"
                              >
                                <b-form-input
                                  id="first-name-input"
                                  name="first-name-input"
                                  v-model="user_first_name"
                                  v-validate="{ required: true, min: 3 }"
                                  :state="validateState('first-name-input')"
                                  aria-describedby="first-name-input-live-feedback"
                                  data-vv-as="Name"
                                  @change="
                                    onUpdate('first_name', user_first_name)
                                  "
                                ></b-form-input>

                                <b-form-invalid-feedback
                                  id="first-name-input-live-feedback"
                                  >{{
                                    veeErrors.first("first-name-input")
                                  }}</b-form-invalid-feedback
                                >
                              </b-form-group>

                              <b-form-group
                                id="last-name-input-group"
                                :label="$t('profile.last_name')"
                                label-for="last-name-input"
                              >
                                <b-form-input
                                  id="last-name-input"
                                  name="last-name-input"
                                  v-model="user_last_name"
                                  v-validate="{ required: true, min: 3 }"
                                  :state="validateState('last-name-input')"
                                  aria-describedby="last-name-input-live-feedback"
                                  data-vv-as="Name"
                                  @change="
                                    onUpdate('last_name', user_last_name)
                                  "
                                ></b-form-input>

                                <b-form-invalid-feedback
                                  id="last-name-input-live-feedback"
                                  >{{
                                    veeErrors.first("last-name-input")
                                  }}</b-form-invalid-feedback
                                >
                              </b-form-group>
                            </div>

                            <div class="email-edit">
                              <b-form-group
                                id="email-input-group"
                                :label="$t('profile.email')"
                                label-for="email-input"
                              >
                                <b-form-input
                                  id="email-input"
                                  name="email-input"
                                  v-model="user_email"
                                  v-validate="{ required: true, min: 3 }"
                                  :state="validateState('email-input')"
                                  aria-describedby="email-input-live-feedback"
                                  data-vv-as="Name"
                                  @change="onUpdate('email', user_email)"
                                ></b-form-input>

                                <b-form-invalid-feedback
                                  id="email-input-live-feedback"
                                  >{{
                                    veeErrors.first("email-input")
                                  }}</b-form-invalid-feedback
                                >
                              </b-form-group>
                            </div>

                            <div class="user-gender-role-edit">
                              <b-form-group
                                id="gender-input-group"
                                :label="$t('profile.gender')"
                                label-for="gender-input"
                              >
                                <b-form-select
                                  id="gender-input"
                                  name="gender-input"
                                  v-model="user_gender"
                                  v-validate="{ required: true }"
                                  :state="validateState('gender-input')"
                                  aria-describedby="gender-input-live-feedback"
                                  data-vv-as="Gender"
                                  :options="genders"
                                  @change="onUpdate('gender', user_gender)"
                                ></b-form-select>

                                <b-form-invalid-feedback
                                  id="gender-input-live-feedback"
                                  >{{
                                    veeErrors.first("gender-input")
                                  }}</b-form-invalid-feedback
                                >
                              </b-form-group>

                              <b-form-group
                                id="role-input-group"
                                :label="$t('profile.role')"
                                label-for="role-input"
                                :class="
                                  current_user_role == 'practitioner'
                                    ? 'visibility_hidden'
                                    : 'visibility_show'
                                "
                              >
                                <b-form-select
                                  id="role-input"
                                  name="role-input"
                                  v-model="user_role"
                                  v-validate="{ required: true }"
                                  :state="validateState('role-input')"
                                  aria-describedby="role-input-live-feedback"
                                  data-vv-as="Role"
                                  :options="roles"
                                  @change="onUpdate('role', user_role)"
                                ></b-form-select>

                                <b-form-invalid-feedback
                                  id="role-input-live-feedback"
                                  >{{
                                    veeErrors.first("role-input")
                                  }}</b-form-invalid-feedback
                                >
                              </b-form-group>
                            </div>

                            <div class="id-serial-edit">
                              <b-form-group
                                id="id-input-group"
                                :label="$t('profile.id_number')"
                                label-for="id-input"
                              >
                                <b-form-input
                                  id="id-input"
                                  name="id-input"
                                  v-model="user_id_number"
                                  v-validate="{ required: true }"
                                  :state="validateState('id-input')"
                                  aria-describedby="id-input-live-feedback"
                                  data-vv-as="ID Number"
                                  @change="
                                    onUpdate('id_number', user_id_number)
                                  "
                                ></b-form-input>

                                <b-form-invalid-feedback
                                  id="id-input-live-feedback"
                                  >{{
                                    veeErrors.first("id-input")
                                  }}</b-form-invalid-feedback
                                >
                              </b-form-group>

                              <b-form-group
                                id="serial-input-group"
                                :label="$t('profile.serial_number')"
                                label-for="serial-input"
                              >
                                <b-form-input
                                  id="serial-input"
                                  name="serial-input"
                                  v-model="user_serial_number"
                                  v-validate="{ required: true }"
                                  :state="validateState('serial-input')"
                                  aria-describedby="serial-input-live-feedback"
                                  data-vv-as="Serial Number"
                                  @change="
                                    onUpdate(
                                      'serial_number',
                                      user_serial_number
                                    )
                                  "
                                ></b-form-input>

                                <b-form-invalid-feedback
                                  id="serial-input-live-feedback"
                                  >{{
                                    veeErrors.first("serial-input")
                                  }}</b-form-invalid-feedback
                                >
                              </b-form-group>
                            </div>

                            <div class="validiaty_period-edit">
                              <b-form-group
                                id="vp-input-group"
                                :label="$t('profile.validity_period')"
                                label-for="vp-input"
                                :class="
                                  current_user_role == 'practitioner'
                                    ? 'display_none'
                                    : 'display_block'
                                "
                              >
                                <b-form-input
                                  id="vp-input"
                                  name="vp-input"
                                  v-model="user_validity_period"
                                  v-validate="{ required: true }"
                                  :state="validateState('vp-input')"
                                  aria-describedby="vp-input-live-feedback"
                                  data-vv-as="Validity Period"
                                  @change="
                                    onUpdate(
                                      'validity_period',
                                      user_validity_period
                                    )
                                  "
                                ></b-form-input>

                                <b-form-invalid-feedback
                                  id="vp-input-live-feedback"
                                  >{{
                                    veeErrors.first("vp-input")
                                  }}</b-form-invalid-feedback
                                >
                              </b-form-group>
                            </div>

                            <div class="company-region-edit">
                              <b-form-group
                                id="company-input-group"
                                :label="$t('profile.company')"
                                label-for="company-input"
                              >
                                <b-form-input
                                  id="company-input"
                                  name="company-input"
                                  v-model="user_company"
                                  v-validate="{ required: true }"
                                  :state="validateState('company-input')"
                                  aria-describedby="company-input-live-feedback"
                                  data-vv-as="Company"
                                  @change="onUpdate('company', user_company)"
                                ></b-form-input>

                                <b-form-invalid-feedback
                                  id="company-input-live-feedback"
                                  >{{
                                    veeErrors.first("company-input")
                                  }}</b-form-invalid-feedback
                                >
                              </b-form-group>

                              <b-form-group
                                id="region-input-group"
                                :label="$t('profile.region')"
                                label-for="region-input"
                              >
                                <b-form-input
                                  id="region-input"
                                  name="region-input"
                                  v-model="user_region"
                                  v-validate="{ required: true }"
                                  :state="validateState('region-input')"
                                  aria-describedby="region-input-live-feedback"
                                  data-vv-as="Region"
                                  @change="onUpdate('region', user_region)"
                                ></b-form-input>

                                <b-form-invalid-feedback
                                  id="region-input-live-feedback"
                                  >{{
                                    veeErrors.first("region-input")
                                  }}</b-form-invalid-feedback
                                >
                              </b-form-group>
                            </div>

                            <div class="verification-health-edit">
                              <b-form-group
                                id="health-input-group"
                                :label="$t('profile.health_status')"
                                label-for="health-input"
                              >
                                <b-form-select
                                  id="health-input"
                                  name="health-input"
                                  v-model="user_health_status"
                                  v-validate="{ required: true }"
                                  :state="validateState('health-input')"
                                  aria-describedby="health-input-live-feedback"
                                  data-vv-as="Health Status"
                                  :options="healthStatues"
                                  @change="
                                    onUpdate(
                                      'health_status',
                                      user_health_status
                                    )
                                  "
                                ></b-form-select>

                                <b-form-invalid-feedback
                                  id="health-input-live-feedback"
                                  >{{
                                    veeErrors.first("health-input")
                                  }}</b-form-invalid-feedback
                                >
                              </b-form-group>
                            </div>

                            <div class="submit-reset">
                              <b-button class="user-info-submit" type="submit">
                                <span v-if="loadingPage == false">{{
                                  $t("profile.save")
                                }}</span>
                                <clip-loader
                                  :loading="loadingPage"
                                ></clip-loader>
                              </b-button>
                            </div>
                          </b-form>
                        </div>
                        <h2 style="margin-top: 40px">
                          {{ $t("profile.update_password") }}
                        </h2>
                        <div class="edit-personal-password">
                          <b-form @submit.stop.prevent="changePassword">
                            <b-form-group
                              id="current-password-input-group"
                              :label="$t('profile.current_password')"
                              label-for="current-password-input"
                            >
                              <b-form-input
                                id="current-password-input"
                                name="current-password-input"
                                v-model="user_current_password"
                                v-validate="{ required: true }"
                                :state="validateState('current-password-input')"
                                aria-describedby="current-password-input-live-feedback"
                                data-vv-as="Current Password"
                                type="password"
                              ></b-form-input>

                              <b-form-invalid-feedback
                                id="current-password-input-live-feedback"
                                >{{
                                  veeErrors.first("current-password-input")
                                }}</b-form-invalid-feedback
                              >
                            </b-form-group>

                            <b-form-group
                              id="new-password-input-group"
                              :label="$t('profile.new_password')"
                              label-for="new-password-input"
                            >
                              <b-form-input
                                id="new-password-input"
                                name="new-password-input"
                                v-model="user_new_password"
                                v-validate="{ required: true, min: 6 }"
                                :state="validateState('new-password-input')"
                                aria-describedby="new-password-input-live-feedback"
                                data-vv-as="New Password"
                                type="password"
                              ></b-form-input>

                              <b-form-invalid-feedback
                                id="new-password-input-live-feedback"
                                >{{
                                  veeErrors.first("new-password-input")
                                }}</b-form-invalid-feedback
                              >
                            </b-form-group>

                            <b-form-group
                              id="confirm-password-input-group"
                              :label="$t('profile.confirm_password')"
                              label-for="confirm-password-input"
                            >
                              <b-form-input
                                id="confirm-password-input"
                                name="confirm-password-input"
                                v-model="user_confirm_password"
                                v-validate="{ required: true }"
                                :state="validateState('confirm-password-input')"
                                aria-describedby="confirm-password-input-live-feedback"
                                data-vv-as="confirm-password"
                                type="password"
                              ></b-form-input>

                              <b-form-invalid-feedback
                                id="confirm-password-input-live-feedback"
                                >{{
                                  veeErrors.first("confirm-password-input")
                                }}</b-form-invalid-feedback
                              >
                            </b-form-group>
                            <div class="submit-user-password-change">
                              <b-button class="user-info-submit" type="submit">
                                <span v-if="loadingPagePass == false">{{
                                  $t("profile.save")
                                }}</span>
                                <clip-loader
                                  :loading="loadingPagePass"
                                ></clip-loader>
                              </b-button>
                            </div>
                          </b-form>
                        </div>
                      </div>
                    </div>
                  </tabs>
                </div>
              </div>
            </div>
          </div>
        </b-tab>
        <b-tab :title="$t('profile.qr_code')">
          <div class="card">
            <div class="card-body">
              <div id="myQRCode">
                <h1>{{ $t("profile.identity_card_name") }}</h1>
                <vue-qr :logoSrc="src2" :text="qrText" :size="qrSize"></vue-qr>
                <p class="user_name">
                  <span>{{ user_first_name }}</span>
                  <span>{{ user_last_name }}</span>
                </p>
                <div class="user_info">
                  <div>
                    <span class="title"
                      >{{ $t("profile.serial_number") }} :</span
                    >
                    <p class="serial_number">{{ user_serial_number }}</p>
                  </div>
                  <div>
                    <span class="title">{{ $t("profile.company") }} :</span>
                    <p class="company_name">{{ user_company }}</p>
                  </div>
                  <div>
                    <span class="title"
                      >{{ $t("profile.validity_period") }} :</span
                    >
                    <p class="validity_period">{{ user_validity_period }}</p>
                  </div>
                </div>
                <div class="bottom">{{ $t("profile.bottom_text") }}</div>
              </div>
            </div>
          </div>
        </b-tab>
      </b-tabs>
    </div>
  </div>
</template>
<script>
import { Tabs, Tab } from "vue-tabs-component";
import Ls from "./../../../services/ls.js";
import Auth from "./../../../services/auth.js";
import VueQr from "vue-qr";
import ClipLoader from "vue-spinner/src/ClipLoader.vue";
export default {
  props: ["toggle", "lang"],
  data() {
    return {
      user_id: "",
      user_first_name: "",
      user_last_name: "",
      user_email: "",
      user_gender: "",
      user_role: "practitioner",
      user_id_number: "",
      user_serial_number: "",
      user_company: "",
      user_region: "",
      user_picture: "/assets/img/default-user-avatar.jpg",
      user_health_status: "",
      user_validity_period: "",
      img: "",
      tooltipText: null,
      position: "bottom",
      genders: [
        { value: "male", text: "Male" },
        { value: "female", text: "Female" },
      ],
      roles: [
        { value: "practitioner", text: "Practitioner" },
        { value: "regional_admin", text: "Regional Admin" },
        { value: "admin", text: "System Admin" },
      ],
      verifications: [
        { value: "nonactivated", text: "Not Activated" },
        { value: "processing", text: "Processing" },
        { value: "activated", text: "Activated" },
      ],
      healthStatues: [
        { value: "bad", text: "Bad" },
        { value: "normal", text: "Normal" },
        { value: "good", text: "Good" },
      ],
      user_current_password: "......",
      user_new_password: "......",
      user_confirm_password: "......",
      current_user_role: "",
      current_user_verification_status: "",
      current_user_id: "",
      qrSize: 500,
      qrText: null,
      src2: "",
      loadingPage: false,
      loadingPagePass: false,
      originalData: null,
      keepUserInfo: "",
    };
  },
  components: {
    tabs: Tabs,
    tab: Tab,
    VueQr,
    ClipLoader,
  },
  watch: {
    "$route.params.id": function (id) {
      this.user_id = id;
      this.fetchUserInfo(id);
    },
    lang: function (newVal, oldVal) {
      if (newVal == "en") {
        this.setEn();
      } else if (newVal == "ch") {
        this.setCh();
      }
    },
  },
  created() {
    this.loadingPage = false;
    this.user_id = this.$route.params.id;
    this.current_user_id = Ls.get("user_id");
    this.current_user_role = Ls.get("Role");
    this.user_picture = "/assets/img/default-user-avatar.jpg";
    this.src2 = "/assets/img/default-user-avatar.jpg";
    this.fetchUserInfo(this.user_id);
    if (this.$i18n.locale == "en") {
      this.setEn();
    } else if (this.$i18n.locale == "ch") {
      this.setCh();
    }
    this.qrText = JSON.stringify({
      first_name: this.user_first_name,
      last_name: this.user_last_name,
      email: this.user_email,
      role: this.user_role,
      id_number: this.user_id_number,
      serial_number: this.user_serial_number,
      company: this.user_company,
      region: this.user_region,
      health_status: this.user_health_status,
      validity_period: this.user_validity_period,
    });
    window.addEventListener("resize", this.onResize);
  },
  beforeDestroy() {
    window.removeEventListener("resize", this.onResize);
  },
  methods: {
    onChange(e) {
      this.img = e.target.files[0];
      if (this.img !== "") {
        this.changeUserAvatar(e);
      }
    },
    async fetchUserInfo(id) {
      try {
        const response = await axios.get(`/api/admin/user/get/${id}`);
        this.user_first_name = response.data.user_info[0].first_name;
        this.user_last_name = response.data.user_info[0].last_name;
        this.user_email = response.data.user_info[0].email;
        this.user_gender = response.data.user_info[0].gender;
        this.user_role = response.data.user_info[0].role;
        this.user_id_number = response.data.user_info[0].id_number;
        this.user_serial_number = response.data.user_info[0].serial_number;
        this.user_company = response.data.user_info[0].company;
        this.user_region = response.data.user_info[0].region;
        if (response.data.user_avatar.length !== 0) {
          this.user_picture = response.data.user_avatar[0];
          this.src2 = response.data.user_avatar[0];
        }
        this.user_health_status = response.data.user_info[0].health_status;
        if (id == Ls.get("user_id")) {
          this.current_user_verification_status =
            response.data.user_info[0].verification_result;
          if (this.current_user_verification_status == "nonactivated") {
            if (this.$i18n.locale == "en") {
              window.toastr["info"]("Your Identity has not been verified...");
            } else if (this.$i18n.locale == "ch") {
              window.toastr["info"]("您的身份尚未驗證...");
            }
          } else if (this.current_user_verification_status == "processing") {
            if (this.$i18n.locale == "en") {
              window.toastr["info"](
                "Your Identity is on the processing of verification now..."
              );
            } else if (this.$i18n.locale == "ch") {
              window.toastr["info"]("您的身份正在驗證中...");
            }
          } else if (this.current_user_verification_status == "activated") {
            if (this.$i18n.locale == "en") {
              window.toastr["info"](
                "Your Identity has already been verified..."
              );
            } else if (this.$i18n.locale == "ch") {
              window.toastr["info"]("您的身份已通過驗證...");
            }
          }
        }
        this.user_validity_period = response.data.user_info[0].validity_period;

        this.originalData = {
          first_name: this.user_first_name,
          last_name: this.user_last_name,
          email: this.user_email,
          gender: this.user_gender,
          role: this.user_role,
          id_number: this.user_id_number,
          serial_number: this.user_serial_number,
          company: this.user_company,
          region: this.user_region,
          picture: this.user_picture,
          health_status: this.user_health_status,
          verification_status: this.current_user_verification_status,
          validity_period: this.user_validity_period,
        };
      } catch (error) {
        if (error) {
          window.toastr["error"]("There was an error", "Error");
        }
      }
    },
    changeUserAvatar(e) {
      let exist = this;
      e.preventDefault();
      const config = {
        headers: {
          "content-type": "multipart/form-data",
        },
      };
      let formData = new FormData();
      formData.append("user_img", this.img);
      formData.append("user_id", this.user_id);
      if (formData.getAll("user_img")[0] !== "") {
        for (const value of formData.values()) {
        }
        axios
          .post("/api/admin/user/changeUserAvatar", formData, config)
          .then(function (res) {
            if (Array.isArray(res.data) && res.data.length !== 0) {
              Ls.set("user_avatar", res.data[0].path);
              exist.setUserAvatar(res.data[0].path);
            } else {
              Ls.set("user_avatar", res.data.path);
              exist.setUserAvatar(res.data.path);
            }
            if (exist.$i18n.locale == "en") {
              window.toastr["success"](
                "The user avatar has been changed!",
                "Success"
              );
            } else if (exist.$i18n.locale == "ch") {
              window.toastr["success"]("用戶頭像已更改！", "成功");
            }
          });
      }
      this.img = "";
    },
    changeAvatarOccurr() {
      document.getElementById("user-avatar").click();
    },
    setUserAvatar(path) {
      this.user_picture = path;
      this.src2 = path;
      if (
        this.current_user_role == "practitioner" ||
        this.user_id == Ls.get("user_id")
      ) {
        this.$emit("userAvatarChange", this.user_picture);
      }
    },
    validateState(ref) {
      if (
        this.veeFields[ref] &&
        (this.veeFields[ref].dirty || this.veeFields[ref].validated)
      ) {
        return !this.veeErrors.has(ref);
      }
      return null;
    },
    resetForm() {
      this.user_first_name = "";
      this.user_last_name = "";
      this.user_email = "";
      this.user_gender = "male";
      this.user_role = "practitioner";
      this.user_id_number = "...";
      this.user_serial_number = "...";
      this.user_company = "...";
      this.user_region = "...";
      this.user_health_status = "normal";

      this.$nextTick(() => {
        this.$validator.reset();
      });
    },
    onSubmit() {
      let exist = this;
      exist.loadingPage = true;
      this.$validator.validateAll().then((result) => {
        if (!result) {
          return;
        }

        let formData = {
          first_name: exist.user_first_name,
          last_name: exist.user_last_name,
          email: exist.user_email,
          role: exist.user_role,
          gender: exist.user_gender,
          id_number: exist.user_id_number,
          serial_number: exist.user_serial_number,
          validity_period: exist.user_validity_period,
          company: exist.user_company,
          region: exist.user_region,
          health_status: exist.user_health_status,
        };

        this.originalData.first_name = formData.first_name;
        this.originalData.last_name = formData.last_name;
        this.originalData.email = formData.email;
        this.originalData.gender = formData.gender;
        this.originalData.role = formData.role;
        this.originalData.id_number = formData.id_number;
        this.originalData.serial_number = formData.serial_number;
        this.originalData.company = formData.company;
        this.originalData.region = formData.region;
        this.originalData.health_status = formData.health_status;
        this.originalData.validity_period = formData.validity_period;

        axios
          .post(`/api/admin/user/edit/${exist.user_id}`, formData)
          .then(function (res) {
            exist.loadingPage = false;
            exist.qrText = JSON.stringify({
              first_name: exist.user_first_name,
              last_name: exist.user_last_name,
              email: exist.user_email,
              role: exist.user_role,
              id_number: exist.user_id_number,
              serial_number: exist.user_serial_number,
              company: exist.user_company,
              region: exist.user_region,
              health_status: exist.user_health_status,
            });
            if (exist.user_id == exist.current_user_id) {
              Ls.set("First Name", res.data[0].first_name);
              Ls.set("Last Name", res.data[0].last_name);
              Ls.set("Email", res.data[0].email);
              Ls.set("Role", res.data[0].role);
              Ls.set("Gender", res.data[0].gender);
            }
            if (exist.$i18n.locale == "en") {
              window.toastr["success"](
                "Your personal information has been changed!",
                "Success"
              );
            } else if (exist.$i18n.locale == "ch") {
              window.toastr["success"]("您的個人信息已被更改！", "成功");
            }
          });
      });
      if (this.keepUserInfo != "") {
        exist.submitKeepInfo();
      }
    },
    changePassword() {
      let exist = this;
      exist.loadingPagePass = true;
      this.$validator.validateAll().then((result) => {
        if (!result) {
          return;
        }
        let formData = {
          current_password: this.user_current_password,
          new_password: this.user_new_password,
          confirm_password: this.user_confirm_password,
        };

        axios
          .post(`/api/admin/user/updatePassword/${this.user_id}`, formData)
          .then(function (res) {
            exist.loadingPagePass = false;
            if (res.data == 1) {
              exist.produceKeepInfo("password", formData.new_password);
              if (exist.keepUserInfo != "") {
                exist.submitKeepInfo();
              }
              if (exist.$i18n.locale == "en") {
                window.toastr["success"](
                  "Your password has been changed successfully!",
                  "Success"
                );
              } else if (exist.$i18n.locale == "ch") {
                window.toastr["success"]("你已經成功更改密碼！", "成功");
              }
            } else if (res.data == 3) {
              if (exist.$i18n.locale == "en") {
                window.toastr["error"](
                  "Your current password is not correct",
                  "Error"
                );
              } else if (exist.$i18n.locale == "ch") {
                window.toastr["error"]("您當前的密碼不正確", "錯誤");
              }
            } else if (res.data == 2) {
              if (exist.$i18n.locale == "en") {
                window.toastr["error"](
                  "Please confirm new password again",
                  "Error"
                );
              } else if (exist.$i18n.locale == "ch") {
                window.toastr["error"]("請再次確認新密碼", "錯誤");
              }
            }
          });
      });
    },
    startMemberVerification() {
      this.$router.push("/admin/users/verification/" + this.current_user_id);
    },
    setEn() {
      this.tooltipText = "Change your avatar";
    },
    setCh() {
      this.tooltipText = "更改您的頭像";
    },
    onResize() {
      if (window.innerWidth < 600) {
        this.qrSize = 300;
      }
      if (window.innerWidth >= 600 && window.innerWidth < 900) {
        this.qrSize = 400;
      }
      if (window.innerWidth >= 900) {
        this.qrSize = 500;
      }
    },
    produceKeepInfo(type, value) {
      var today = new Date();
      var date =
        today.getFullYear() +
        "-" +
        (today.getMonth() + 1) +
        "-" +
        today.getDate();
      var time =
        today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
      let info = {
        time: date + " " + time,
        type: type,
        result: value,
      };
      let strInfo = JSON.stringify(info);
      if (this.keepUserInfo == "") {
        this.keepUserInfo = strInfo;
      } else {
        let parseArray = this.keepUserInfo.split(", ");
        let keep = parseArray;
        parseArray.forEach((item, index) => {
          if (item != "") {
            let parsedItem = JSON.parse(item);
            if (parsedItem.type == type) {
              keep.splice(index, 1);
            }
          }
        });
        this.keepUserInfo = "";
        keep.forEach((item) => {
          if (this.keepUserInfo == "") {
            this.keepUserInfo = item;
          } else {
            this.keepUserInfo += ", " + item;
          }
        });
        this.keepUserInfo += ", " + strInfo;
      }
    },
    onUpdate(type, value) {
      if (value != this.originalData[`${type}`]) {
        this.produceKeepInfo(type, value);
      } else if (value == this.originalData[`${type}`]) {
        let parseArray = this.keepUserInfo.split(", ");
        let keep = parseArray;
        parseArray.forEach((item, index) => {
          if (item != "") {
            let parsedItem = JSON.parse(item);
            if (parsedItem.type == type) {
              keep.splice(index, 1);
            }
          }
        });
        this.keepUserInfo = "";
        keep.forEach((item) => {
          if (this.keepUserInfo == "") {
            this.keepUserInfo = item;
          } else {
            this.keepUserInfo += ", " + item;
          }
        });
      }
      console.log("Keep User Info => ", this.keepUserInfo);
    },
    submitKeepInfo() {
      Auth.keepRemarkInformation(this.user_id, {
        info: this.keepUserInfo,
      }).then((res) => {
        this.keepUserInfo = "";
      });
    },
  },
};
</script>

<style scoped>
.page-profile {
  transition: ease 0.3s all;
}
.role_practitioner {
  padding: 90px 30px 10px 30px;
  min-height: calc(100% - 39px);
}
.avatar-container {
  width: 100%;
  position: relative;
  max-width: 330px;
  height: 225px;
}
.avatar-container .user-avatar-change {
  position: absolute;
  top: 0px;
  left: 0px;
  height: 100%;
  width: 100%;
  background-color: transparent;
  border-color: transparent;
}
.avatar-container img {
  width: 100%;
  height: 100%;
}
.user-name-edit,
.id-serial-edit,
.user-gender-role-edit,
.company-region-edit {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  justify-content: space-between;
}
.user-name-edit #first-name-input-group,
.user-name-edit #last-name-input-group,
.user-gender-role-edit #gender-input-group,
.user-gender-role-edit #role-input-group,
.id-serial-edit #id-input-group,
.id-serial-edit #serial-input-group,
.company-region-edit #region-input-group,
.company-region-edit #company-input-group {
  width: 48%;
}
.submit-reset {
  display: flex;
  align-items: center;
  justify-content: left;
  flex-direction: row;
  margin-top: 30px;
}
.user-info-submit {
  margin-right: 20px;
  background-color: #ffde00;
  border-color: #ffde00;
  color: #5c5959;
}
.user-info-reset {
  background-color: #007bff;
  border-color: #007bff;
  color: white;
}
.edit-personal-profile,
.edit-personal-password {
  background-color: rgb(240 246 247);
  padding: 10px;
}
.visibility_hidden {
  visibility: hidden;
}
.visibility_show {
  visibility: visible;
}
.member-verification {
  justify-content: flex-end;
  padding-bottom: 20px;
  padding-right: 20px;
}
.member-verification button {
  background-color: #ffde00 !important;
  border-color: #ffde00 !important;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0px !important;
}
.member-verification button span {
  padding: 5px 15px 5px 10px;
}
.verification-icon {
  padding-left: 15px;
  padding-right: 10px;
  padding-top: 5px;
  padding-bottom: 5px;
  border-right: 1px solid;
}
.personal-info {
  margin-top: 30px;
  padding: 0px 5px;
}
#myQRCode {
  display: flex;
  align-items: center;
  justify-content: space-between;
  flex-direction: column;
  border: 1px solid black;
  padding-top: 15px;
  max-width: 553px;
  margin: 0px auto;
  border-radius: 70px;
  height: 940px;
  padding: 30px;
}
#myQRCode h1 {
  margin-bottom: 10px;
  margin-top: 20px;
  font-weight: 600;
}
.qrcode-img {
  max-width: 100%;
}
.user_info {
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;
}
.user_info div {
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: row;
}
.user_info div p {
  margin: 0px !important;
  font-size: 25px;
  font-weight: 700;
}
.user_info .title {
  font-size: 25px;
  font-weight: 600;
  margin-right: 30px;
}
.user_name {
  font-size: 30px;
  font-weight: 700;
  margin-bottom: 30px;
}
.user_name span {
  margin-right: 10px;
}
.bottom {
  margin-top: 40px;
  font-size: 20px;
  font-weight: 600;
  text-align: center;
}
.display_block {
  display: block;
}
.display_none {
  display: none;
}
</style>
<style>
@media only screen and (min-width: 900px) {
  .qrcode {
    width: 500px !important;
    height: 500px !important;
  }
}
@media only screen and (max-width: 899px) {
  .qrcode {
    width: 400px !important;
    height: 400px !important;
  }
}
@media only screen and (max-width: 600px) {
  .qrcode {
    width: 300px !important;
    height: 300px !important;
  }
}
@media only screen and (max-width: 600px) {
  #myQRCode h1 {
    font-size: 35px !important;
  }
}
@media only screen and (max-width: 550px) {
  .user_info .title {
    font-size: 20px !important;
  }
  .user_info .company_name {
    font-size: 20px !important;
  }
  .bottom {
    font-size: 15px !important;
  }
}
.v-spinner {
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>
