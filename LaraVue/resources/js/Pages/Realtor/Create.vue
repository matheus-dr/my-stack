<template>
  <form @submit.prevent="create">
    <div class="grid grid-cols-6 gap-4">
      <div class="col-span-2">
        <label class="label-form">Beds</label>
        <input
          v-model.number="form.beds"
          class="input-form"
          type="text"
        />
        <div v-if="form.errors.beds" class="input-error">
          {{ form.errors.beds }}
        </div>
      </div>
      <div class="col-span-2">
        <label class="label-form">Baths</label>
        <input
          v-model.number="form.baths"
          class="input-form"
          type="text"
        />
        <div v-if="form.errors.baths" class="input-error">
          {{ form.errors.baths }}
        </div>
      </div>
      <div class="col-span-2">
        <label class="label-form">Area</label>
        <input
          v-model.number="form.area"
          class="input-form"
          type="text"
        />
        <div v-if="form.errors.area" class="input-error">
          {{ form.errors.area }}
        </div>
      </div>
      <div class="col-span-4">
        <label class="label-form">City</label>
        <input
          v-model="form.city"
          class="input-form"
          type="text"
        />
        <div v-if="form.errors.city" class="input-error">
          {{ form.errors.city }}
        </div>
      </div>
      <div class="col-span-2">
        <label class="label-form">Code</label>
        <input
          v-model="form.code"
          class="input-form"
          type="text"
        />
        <div v-if="form.errors.code" class="input-error">
          {{ form.errors.code }}
        </div>
      </div>
      <div class="col-span-4">
        <label class="label-form">Street</label>
        <input
          v-model="form.street"
          class="input-form"
          type="text"
        />
        <div v-if="form.errors.street" class="input-error">
          {{ form.errors.street }}
        </div>
      </div>
      <div class="col-span-2">
        <label class="label-form">Street Nr</label>
        <input
          v-model.number="form.street_nr"
          class="input-form"
          type="text"
        />
        <div v-if="form.errors.street_nr" class="input-error">
          {{ form.errors.street_nr }}
        </div>
      </div>
      <div class="col-span-6">
        <label class="label-form">Price</label>
        <input
          v-model.number="form.price"
          class="input-form"
          type="text"
        />
        <div v-if="form.errors.price" class="input-error">
          {{ form.errors.price }}
        </div>
      </div>
      <div class="col-span-6">
        <button class="btn-primary" type="submit">
          Create
        </button>
      </div>
    </div>
  </form>
</template>

<script setup>
import { useForm } from '@inertiajs/vue3'

const form = useForm({
  beds: 0,
  baths: 0,
  area: 0,
  city: null,
  code: null,
  street: null,
  street_nr: 0,
  price: 0,
})

const create = () => {
  form.post(route('realtor.listing.store'))
}
</script>
