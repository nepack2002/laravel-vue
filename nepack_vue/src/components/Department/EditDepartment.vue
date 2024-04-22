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
          Manage departments in the company
        </p>
      </div>
      <button
        class="inline-flex gap-x-2 items-center py-2.5 px-4 text-white bg-indigo-600 rounded-xl hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-1"
      >
        <router-link
          :to="{ name: 'User' }"
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
                'text-red-500': errorMessage.name,
              }"
              for="name"
              class="input"
              >Name:</label
            >
            <input type="text" id="name" v-model="form.name" class="input2" />
            <span v-if="errorMessage.name" class="text-red-500 text-sm">{{
              errorMessage.name[0]
            }}</span>
          </div>
          <div>
            <label
              :class="{
                'text-red-500': errorMessage.department_id,
              }"
              class="input"
              >Phòng ban:</label
            >
            <select class="input2" v-model="form.parent_id">
              <option v-for="department in departments" :key="department.id" :value="department.id">
                {{ department.id }} - {{ department.name }}
              </option>
            </select>
            <span v-if="errorMessage.department_id" class="text-red-500 text-sm">{{
              errorMessage.department_id[0]
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
                Change successfully
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
import axios from "axios";
import { useRoute } from "vue-router";
import { useUserStore } from "../../store/auth.js";
export default {
  setup() {
    const errorMessage = ref({});
    const showAddSuccess = ref(false);
    const form = ref({
      name: "",
      parent_id: "",
    });


    const userStore = useUserStore();
    onMounted(async () => {
      await userStore.fetchUser();
      fetchDepartments();
    });


    const departments = ref([]);
    const fetchDepartments = async () => {
      try {
        const response = await axios.get("http://127.0.0.1:8000/api/departments", {
          headers: {
            Authorization: `Bearer ${userStore.token}`,
          },
        });
        departments.value = response.data.data;
      } catch (error) {
        console.error("Lỗi khi lấy danh sách phòng ban:", error);
      }
    };

    const route = useRoute();
    const getDepartments = async () => {
      try {
        const response = await axios.get(
          `http://127.0.0.1:8000/api/departments/${route.params.id}`,
          {
            headers: {
              Authorization: `Bearer ${localStorage.getItem("token")}`,
            },
          }
        );
        form.value = response.data;
      } catch (error) {
        console.error("Lỗi khi lấy thông tin xe:", error);
      }
    };
     const handleSubmit = async (event) => {
      event.preventDefault(); 

      try {
        const formData = new FormData();
        formData.append("name", form.value.name);
        formData.append("parent_id", form.value.parent_id);
        await axios.post(
          `http://127.0.0.1:8000/api/departments/${route.params.id}`,
          formData,
          {
            headers: {
              Authorization: `Bearer ${userStore.token}`,
            },
          }
        );
        showAddSuccess.value = true;
        errorMessage.value = []
        setTimeout(() => {
          showAddSuccess.value = false;
        }, 2000);
      } catch (error) {
        errorMessage.value = error.response.data.errors;
      }
    };
    onMounted(() => {
      getDepartments();
    });
    return {
      form,
      handleSubmit,
      showAddSuccess,
      errorMessage,
      departments,
    };
  },
};
</script>
