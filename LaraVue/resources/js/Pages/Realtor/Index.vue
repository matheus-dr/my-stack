<template>
  <h1 class="text-3xl mb-4">Your Listings</h1>
  <section>
    <RealtorFilters :filters="filters" />
  </section>
  <section class="grid grid-cols-1 lg:grid-cols-2 gap-2">
    <Box v-for="listing in listings.data" :key="listing.id" :class="{'border-dashed': listing.deleted_at}">
      <div class="flex flex-col md:flex-row gap-2 md:items-center justify-between">
        <div :class="{'opacity-25': listing.deleted_at}">
          <div class="xl:flex items-center gap-2">
            <Price :price="listing.price" class="text-2xl font-medium" />
            <ListingSpace :listing="listing" />
          </div>
          <ListingAddress :listing="listing" class="text-gray-500" />
        </div>
        <div class="flex items-center gap-1 text-gray-600 dark:text-gray-300">
          <a
            :href="route('listing.show', [listing.id])"
            class="btn-outline text-xs font-medium"
            target="_blank"
          >
            Preview
          </a>
          <Link
            :href="route('realtor.listing.edit', [listing.id])"
            class="btn-outline text-xs font-medium"
          >
            Edit
          </Link>
          <Link
            v-if="!listing.deleted_at"
            :href="route('realtor.listing.destroy', [listing.id])"
            as="button"
            class="btn-outline text-xs font-medium"
            method="DELETE"
          >
            Delete
          </Link>
          <Link
            v-else
            :href="route('realtor.listing.restore', [listing.id])"
            as="button"
            class="btn-outline text-xs font-medium"
            method="PUT"
          >
            Restore
          </Link>
        </div>
      </div>
    </Box>
  </section>
  <section v-if="listings.data.length" class="w-full flex justify-center my-4">
    <Pagination :links="listings.links" />
  </section>
</template>

<script setup>
import Box from '@/Components/Box.vue'
import Price from '@/Components/Price.vue'
import ListingSpace from '@/Components/ListingSpace.vue'
import ListingAddress from '@/Components/ListingAddress.vue'
import { Link } from '@inertiajs/vue3'
import RealtorFilters from '@/Pages/Realtor/Components/RealtorFilters.vue'
import Pagination from '@/Components/Pagination.vue'

defineProps({
  listings: Object,
  filters: Object,
})
</script>
