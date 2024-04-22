<template>
  <div class="mx-auto w-[100%] sm:ml-64">
    <div
      class="flex items-center justify-between py-7 px-10 border-y border-gray-200"
    >
      <div>
        <h1 class="text-2xl font-semibold leading-relaxed text-gray-800">
          CHANGE INFORMATION
        </h1>
        <p class="text-sm font-medium text-gray-500">
          Manage cars in the company
        </p>
      </div>
      <button
        class="inline-flex gap-x-2 items-center py-2.5 px-4 text-white bg-indigo-600 rounded-xl hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-1"
      >
        <router-link
          :to="{ name: 'Car' }"
          class="text-sm font-semibold tracking-wide"
          >Back</router-link
        >
      </button>
    </div>
    <div class="flex justify-center py-16">
      <div class="w-[90%] md:w-[600px]">
        <form
          @submit.prevent="handleSubmit"
          class="p-8 border border-gray-300 shadow-md rounded-lg relative"
          enctype="multipart/form-data"
          method="post"
        >
          <div>
            <label
              :class="{
                'text-red-500': errorMessage.ten_xe,
              }"
              for="ten_xe"
              class="input"
              >Tên xe:
            </label>
            <input
              type="text"
              id="ten_xe"
              v-model="form.ten_xe"
              class="input2"
            />
            <span v-if="errorMessage.ten_xe" class="text-red-500 text-sm">{{
              errorMessage.ten_xe[0]
            }}</span>
          </div>
          <div>
            <label
              :class="{
                'text-red-500': errorMessage.mau_xe,
              }"
              for="mau_xe"
              class="input"
              >Màu xe:</label
            >
            <input
              type="text"
              id="mau_xe"
              v-model="form.mau_xe"
              class="input2"
            />
            <span v-if="errorMessage.mau_xe" class="text-red-500 text-sm">{{
              errorMessage.mau_xe[0]
            }}</span>
          </div>
          <div>
            <label
              :class="{
                'text-red-500': errorMessage.user_id,
              }"
              for="user_id"
              class="input"
              >Người lái:</label
            >
            <select id="user_id" class="input2" v-model="form.user_id">
              <option v-for="user in users" :key="user.id" :value="user.id">
                {{ user.id }} - {{ user.name }}
              </option>
            </select>
            <span v-if="errorMessage.user_id" class="text-red-500 text-sm">{{
              errorMessage.user_id[0]
            }}</span>
          </div>
          <div>
            <label
              :class="{
                'text-red-500': errorMessage.bien_so_xe,
              }"
              for="bien_so_xe"
              class="input"
              >Biển số xe:</label
            >
            <input
              type="text"
              id="bien_so_xe"
              v-model="form.bien_so_xe"
              class="input2"
            />
            <span v-if="errorMessage.bien_so_xe" class="text-red-500 text-sm">{{
              errorMessage.bien_so_xe[0]
            }}</span>
          </div>
          <div>
            <label
              :class="{
                'text-red-500': errorMessage.so_khung,
              }"
              for="bien_khung"
              class="input"
              >Số khung:</label
            >
            <input
              type="text"
              id="so_khung"
              v-model="form.so_khung"
              class="input2"
            />
            <span v-if="errorMessage.so_khung" class="text-red-500 text-sm">{{
              errorMessage.so_khung[0]
            }}</span>
          </div>
          <div>
            <label
              :class="{
                'text-red-500': errorMessage.so_cho,
              }"
              for="bien_so_xe"
              class="input"
              >Số chỗ:</label
            >
            <input
              type="number"
              id="so_cho"
              v-model="form.so_cho"
              class="input2"
            />
            <span v-if="errorMessage.so_cho" class="text-red-500 text-sm">{{
              errorMessage.so_cho[0]
            }}</span>
          </div>
          <div>
            <label
              :class="{
                'text-red-500': errorMessage.dac_diem_mac_dinh,
              }"
              for="dac_diem_mac_dinh"
              class="input"
              >Đặc điểm mặc định:</label
            >
            <select
              id="dac_diem_mac_dinh"
              v-model="form.dac_diem_mac_dinh"
              class="input2"
            >
              <option value="A">A</option>
              <option value="B">B</option>
            </select>
            <span
              v-if="errorMessage.dac_diem_mac_dinh"
              class="text-red-500 text-sm"
              >{{ errorMessage.dac_diem_mac_dinh[0] }}</span
            >
          </div>
          <div>
            <label
              :class="{
                'text-red-500': errorMessage.so_dau_xang_tieu_thu,
              }"
              for="so_dau_xang_tieu_thu"
              class="input"
              >Số dầu, xăng tiêu thụ (l/100km):</label
            >
            <input
              type="number"
              id="so_dau_xang_tieu_thu"
              v-model="form.so_dau_xang_tieu_thu"
              class="input2"
            />
            <span
              v-if="errorMessage.so_dau_xang_tieu_thu"
              class="text-red-500 text-sm"
              >{{ errorMessage.so_dau_xang_tieu_thu[0] }}</span
            >
          </div>
          <div>
            <label
              :class="{
                'text-red-500': errorMessage.ngay_bao_duong_gan_nhat,
              }"
              for="ngay_bao_duong_gan_nhat"
              class="input"
              >Ngày bảo dưỡng gần nhất:</label
            >
            <input
              type="date"
              id="ngay_bao_duong_gan_nhat"
              class="input2"
              v-model="form.ngay_bao_duong_gan_nhat"
            />
            <span
              v-if="errorMessage.ngay_bao_duong_gan_nhat"
              class="text-red-500 text-sm"
              >{{ errorMessage.ngay_bao_duong_gan_nhat[0] }}</span
            >
          </div>
          <div>
            <label
              :class="{
                'text-red-500': errorMessage.han_dang_kiem_tiep_theo,
              }"
              for="han_dang_kiem_tiep_theo"
              class="input"
              >Hạn đăng kiểm tiếp theo:</label
            >
            <input
              type="date"
              id="han_dang_kiem_tiep_theo"
              class="input2"
              v-model="form.han_dang_kiem_tiep_theo"
            />
            <span
              v-if="errorMessage.han_dang_kiem_tiep_theo"
              class="text-red-500 text-sm"
              >{{ errorMessage.han_dang_kiem_tiep_theo[0] }}</span
            >
          </div>
          <div>
            <label
              :class="{
                'text-red-500': errorMessage.anh_xe,
              }"
              for="anh_xe"
              class="input"
              >Ảnh xe:</label
            >
            <input
              type="file"
              id="anh_xe"
              class="input2"
              @change="handleFileUpload"
            />
            <!-- Hiển thị ảnh đã chọn -->
            <div v-if="form.anh_xe">
              <img :src="form.anh_xe" alt="" />
            </div>
            <div v-if="form.anh_xe_preview">
              <img :src="form.anh_xe_preview" alt="" />
            </div>
            <span v-if="errorMessage.anh_xe" class="text-red-500 text-sm">{{
              errorMessage.anh_xe[0]
            }}</span>
          </div>
          <div>
            <div class="flex items-center">
              <button
                type="submit"
                class="btn bg-gray-600 hover:bg-gray-500 text-white font-medium py-2 px-4 rounded mt-4"
              >
                Change
              </button>
              <p
                v-if="showAddSuccess"
                class="text-green-500 ml-10 font-semibold text-md"
              >
                Change succesfully
              </p>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
import { ref, onMounted } from "vue";
import { useUserStore } from "../../store/auth.js";
import axios from "axios";
import { useRoute } from "vue-router";
export default {
  setup() {
    const errorMessage = ref({});
    const showAddSuccess = ref(false);
    const form = ref({
      ten_xe: "",
      mau_xe: "",
      user_id: "",
      bien_so_xe: "",
      so_khung: "",
      so_cho: "",
      dac_diem_mac_dinh: "",
      so_dau_xang_tieu_thu: "",
      ngay_bao_duong_gan_nhat: "",
      han_dang_kiem_tiep_theo: "",
      anh_xe: "",
    });

    const users = ref([]);
    const userStore = useUserStore();
    onMounted(async () => {
      await userStore.fetchUser();
    });

    const fetchUsers = async () => {
      try {
        const response = await axios.get("http://127.0.0.1:8000/api/users", {
          headers: {
            Authorization: `Bearer ${userStore.token}`,
          },
        });
        users.value = response.data.data;
      } catch (error) {
        console.error("Lỗi khi lấy danh sách người lái:", error);
      }
    };
    const route = useRoute();
    const getCars = async () => {
      try {
        const response = await axios.get(
          `http://127.0.0.1:8000/api/cars/${route.params.id}`,
          {
            headers: {
              Authorization: `Bearer ${userStore.token}`,
            },
          }
        );
        form.value = response.data; // Cập nhật giá trị của reactivity object form với thông tin của chiếc xe
      } catch (error) {
        console.error("Lỗi khi lấy thông tin xe:", error);
      }
    };
    const handleSubmit = async (event) => {
      event.preventDefault(); // Ngăn chặn form gửi đi mặc định

      try {
        const formData = new FormData();
        // Thêm các trường vào FormData
        formData.append("ten_xe", form.value.ten_xe);
        formData.append("mau_xe", form.value.mau_xe);
        formData.append("user_id", form.value.user_id);
        formData.append("bien_so_xe", form.value.bien_so_xe);
        formData.append("so_khung", form.value.so_khung);
        formData.append("so_cho", form.value.so_cho);
        formData.append("dac_diem_mac_dinh", form.value.dac_diem_mac_dinh);
        formData.append(
          "so_dau_xang_tieu_thu",
          form.value.so_dau_xang_tieu_thu
        );
        formData.append(
          "ngay_bao_duong_gan_nhat",
          form.value.ngay_bao_duong_gan_nhat
        );
        formData.append(
          "han_dang_kiem_tiep_theo",
          form.value.han_dang_kiem_tiep_theo
        );
        if (form.value.anh_xe) {
          formData.append("anh_xe", form.value.anh_xe);
        }
        const response = await axios.post(
          `http://127.0.0.1:8000/api/cars/${route.params.id}`,
          formData,
          {
            headers: {
              "Content-Type": "multipart/form-data",
              Authorization: `Bearer ${userStore.token}`,
            },
          } // Gửi dữ liệu form lên máy chủ
        );
        console.log(formData);
        showAddSuccess.value = true;
        // Tự động ẩn thông báo sau 2 giây
        setTimeout(() => {
          showAddSuccess.value = false;
        }, 2000);
        console.log(response.data); // Log response từ máy chủ
        // Reset form hoặc thực hiện các hành động khác sau khi cập nhật thành công
      } catch (error) {
        errorMessage.value = error.response.data.errors;
      }
    };
    onMounted(() => {
      fetchUsers();
      getCars();
    });
    const handleFileUpload = (event) => {
      const file = event.target.files[0];
      form.value.anh_xe = file;
      console.log(form.value.anh_xe);
      const reader = new FileReader();
      reader.onload = () => {
        form.value.anh_xe_preview = reader.result;
      };
      reader.readAsDataURL(file);
    };
    return {
      form,
      users,
      handleFileUpload,
      handleSubmit,
      showAddSuccess,
      errorMessage,
    };
  },
};
</script>

