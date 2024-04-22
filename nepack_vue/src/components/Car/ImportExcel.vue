<template>
  <div class="mx-auto w-[100%] sm:ml-64">
    <div
      class="flex items-center justify-between py-7 px-10 border-y border-gray-200"
    >
      <div>
        <h1 class="text-2xl font-semibold leading-relaxed text-gray-800">
          IMPORT FILE EXCEL TO DATABASE CAR
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
    <div class="mx-auto max-w-lg p-6 mt-28 bg-white shadow-lg rounded-lg">
      <h1 class="text-2xl font-semibold mb-4">Import File Form</h1>
      <form
        @submit.prevent="handleSubmit"
        method="POST"
        enctype="multipart/form-data"
      >
        <div class="mb-4">
          <label for="file" class="block text-gray-700 text-sm font-bold mb-2"
            >Choose File</label
          >
          <input
            type="file"
            id="file"
            class="w-full border rounded-md py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:ring focus:border-blue-300"
            @change="handleFileChange"
          />
        </div>
        <div class="flex justify-end">
          <button
            type="submit"
            class="bg-blue-500 text-white py-2 px-4 rounded-md hover:bg-blue-600 focus:outline-none focus:ring focus:border-blue-300"
          >
            Submit
          </button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import { ref, onMounted } from "vue";
import axios from "axios";
import { useUserStore } from "../../store/auth.js";

export default {
  setup() {
    const selectedFile = ref(null);
    const userStore = useUserStore();

    onMounted(async () => {
      await userStore.fetchUser();
    });

    const handleFileChange = (event) => {
      selectedFile.value = event.target.files[0];
      console.log(selectedFile.value);
    };

    const handleSubmit = () => {
      if (selectedFile.value) {
        const formData = new FormData();
        formData.append("file", selectedFile.value);

        axios
          .post("http://127.0.0.1:8000/api/car/import", formData, {
            headers: {
              "Content-Type": "multipart/form-data",
              Authorization: `Bearer ${userStore.token}`,
            },
          })
          .then((response) => {
            console.log(response.data);
          })
          .catch((error) => {
            console.error("Error uploading file:", error);
          });
      } else {
        console.error("No file selected.");
      }
    };

    return { selectedFile, handleFileChange, handleSubmit };
  },
};
</script>

