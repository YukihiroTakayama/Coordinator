<template>
  <div>
    <Header />
    <Breadcrumbs />
    <!-- section start -->
    <b-overlay :show="overlay" rounded="sm">
    <section>
    <div class="collection-wrapper">
        <div class="container">
            <div class="row">
              <div class="col-lg-5">
                <div class="page-title">
                  <b-form-input
                    type="text"
                    v-model="coordinate.title"
                    v-show="editFlag"
                  ></b-form-input>
                  <h2 v-show="!editFlag">{{ coordinate.title }}</h2>
                </div>
              </div>
              <div class="col-lg-7" style="text-align: right;">
                <button
                  class="btn btn-solid btn-primary"
                  title="Published"
                  @click="coordinate.is_published = true; updateCoordinate()"
                  v-if="!editFlag && !coordinate.is_published"
                  style="padding: 13px 29px; width: 140px;"
                >Public</button>
                <button
                  class="btn btn-solid btn-danger"
                  title="Private"
                  @click="coordinate.is_published = false; updateCoordinate()"
                  v-if="!editFlag && coordinate.is_published"
                  style="padding: 13px 29px; width: 140px;"
                >Private</button>
                <button
                  class="btn btn-solid btn-primary"
                  title="Edit"
                  @click="editCoordinate()"
                  v-show="!editFlag"
                  style="padding: 13px 29px; width: 120px;"
                >Edit</button>
                <button
                  class="btn btn-solid btn-secondary"
                  title="Cancel"
                  @click="cancelEdit()"
                  v-show="editFlag"
                  style="padding: 13px 29px; width: 120px;"
                >Cancel</button>
                <button
                  class="btn btn-solid btn-primary"
                  title="Save"
                  @click="updateCoordinate()"
                  v-show="editFlag"
                  style="padding: 13px 29px; width: 120px;"
                >Save</button>
              </div>
            </div>
            <div class="row">
                <div class="col-lg-5 col-sm-10 col-xs-12">
                  <div v-swiper:mySwiper="swiperOption" ref="mySwiper">
                    <div class="swiper-wrapper">
                      <div
                        class="swiper-slide"
                        v-for="(image, index) in coordinate.images"
                        :key="index"
                      >
                        <a href="javascript:void(0)">
                          <img
                            :src="image"
                            class="img-fluid bg-img"
                            @click="clickFileForm()"
                          />
                        </a>
                      </div>
                      <div
                        class="swiper-slide"
                        v-if="coordinate.images.length == 0"
                      >
                        <a href="javascript:void(0)">
                          <img
                            :src="getImgUrl('1.jpg')"
                            class="img-fluid bg-img"
                            @click="clickFileForm()"
                          />
                        </a>
                      </div>
                    </div>
                  </div>
                  <input
                    ref="file-input"
                    type="file"
                    multiple
                    accept="image/*"
                    @change="onChangeFiles"
                    style="display: none;"
                  >
                </div>
                <div class="col-lg-7 col-sm-10 col-xs-12">
                  <div class="page-title">
                    <h3>{{ 'ITEMS' }}</h3>
                  </div>
                  <div class="product-wrapper-grid swiper-container" :class="'list-view'" style="position: relative; overflow-y: scroll; max-height: 750px">
                    <div class="text-center section-t-space section-b-space" v-if="coordinate.parts.length === 0">
                      <b-spinner style="width: 3rem; height: 3rem;" label="Loading..."></b-spinner>
                      <div><strong>Loading...</strong></div>
                    </div>
                    <draggable v-model="coordinate.parts" @end="draggableEnd" :scroll-sensitivity="200" :force-fallback="true" :options="{ animation: 300, handle: '.handle' }">
                      <div
                      class="col-grid-box"
                      :class="'col-lg-12'"
                      v-for="(item, index) in coordinate.parts"
                      :key="index"
                      v-if="!coordinate.parts[index].is_deleted && item.params"
                      >
                      <div v-show="editFlag">
                        <div class="product-box">
                            <productBox
                              :product="item.params"
                              :index="index"
                              :class="'handle'"
                              :style="'cursor: move;'"
                            />

                          <div style="display: block; align-self: center; margin-left: auto;">
                            <button
                              class="btn btn-solid btn-success"
                              title="Change"
                              v-show="editFlag"
                              style="padding: 13px 29px; display: block; width: 100%;"
                              v-b-modal="'items-modal-' + index"
                            >Change</button>
                            <button
                              class="btn btn-solid btn-danger"
                              title="Save"
                              @click="coordinate.parts[index].is_deleted = true"
                              v-show="editFlag"
                              style="padding: 13px 29px; display: block; width: 100%;"
                            >Delete</button>
                          </div>
                        </div>
                      </div>
                        <a v-show="!editFlag" :href="item.params ? item.params.affiliateUrl : ''" target="_blank">
                          <div class="product-box">
                            <productBox
                              :product="item.params"
                              :index="index"
                            />
                          </div>
                        </a>
                        <b-modal :id="'items-modal-' + index" size="xl" title="アイテム一覧">
                          <items @change="changeItem(index, $event)"
                                 @close="$bvModal.hide('items-modal-' + index);" />
                        </b-modal>
                      </div>
                    </draggable>
                  </div>
                </div>
            </div>
            <div class="row">
              <div class="col-lg-5"></div>
              <div class="col-lg-7" style="text-align: right;">
                <button
                  class="btn btn-solid btn-primary"
                  title="Save"
                  @click="addItem()"
                  v-show="editFlag"
                  style="padding: 13px 29px;"
                  v-b-modal.add-item-modal
                >Add Item</button>
                <b-modal :id="'add-item-modal'" size="xl" title="アイテム一覧">
                  <items @change="addItem($event)"
                         @close="$bvModal.hide('add-item-modal');" />
                </b-modal>
              </div>
            </div>
        </div>
    </div>
</section>
<section class="tab-product m-0">
      <div class="container">
                <div class="row">
                  <div class="col-sm-12 col-lg-12">
                    <b-tabs card>
                      <b-tab title="caption" active>
                        <b-form-textarea
                          id="caption"
                          v-model="coordinate.caption"
                          placeholder=""
                          rows="3"
                          max-rows="6"
                          v-show="editFlag"
                        ></b-form-textarea>
                        <b-card-text v-show="!editFlag" style="padding: 0.375rem 0.75rem;
    font-size: 1rem;">{{ coordinate.caption }}</b-card-text>
                      </b-tab>
                    </b-tabs>
                  </div>
                </div>
      </div>
              </section>
    <!-- Section ends -->
    </b-overlay>
    <relatedProduct :productTYpe="productTYpe" :productId="productId" />
    <Footer />
  </div>
</template>
<script>
import { mapState, mapGetters } from 'vuex'
import Header from '../../../components/header/header1'
import Footer from '../../../components/footer/footer'
import Breadcrumbs from '../../../components/widgets/breadcrumbs'
import Timer from '../../../components/widgets/timer'
import relatedProduct from '../../../components/widgets/related-products'
import items from '../../items/index'
import productBox from '../../../components/product-box/product-box'
import DirectUploader from '@/lib/DirectUploader'
import draggable from 'vuedraggable'

export default {
  components: {
    Header,
    Footer,
    Breadcrumbs,
    Timer,
    relatedProduct,
    items,
    productBox,
    draggable
  },
  data() {
    return {
      counter: 1,
      activeColor: '',
      selectedSize: '',
      qty: '',
      size: [],
      productTYpe: '',
      productId: '',
      swiperOption: {
        slidesPerView: 1,
        spaceBetween: 20,
        freeMode: true
      },
      swiperOption1: {
        direction: 'vertical',
        slidesPerView: 3,
        spaceBetween: 30,
        freeMode: true,
        centeredSlides: false
      },
      coordinate: {
        parts: [],
        images: [],
        blob_ids: []
      },
      editFlag: false,
      overlay: false
    }
  },
  localStorage: {
    coordinate: {
      type: Object
    },
    items: {
      type: Array
    }
  },
  computed: {
    ...mapState({
      currency: state => state.products.currency
    }),
    ...mapGetters({
      curr: 'products/changeCurrency'
    }),
    getDetail: function () {
      return this.$store.getters['products/getProductById'](1)
    },
    swiper() {
      return this.$refs.mySwiper.swiper
    }
  },
  mounted() {
    // For displaying default color and size on pageload
    this.uniqColor = this.getDetail.variants[0].color
    this.sizeVariant(this.getDetail.variants[0].image_id)
    // Active default color
    this.activeColor = this.uniqColor
    this.changeSizeVariant(this.getDetail.variants[0].size)
    this.fetchCoordinate()
  },
  methods: {
    priceCurrency: function () {
      this.$store.dispatch('products/changeCurrency')
    },
    addToWishlist: function (product) {
      this.$store.dispatch('products/addToWishlist', product)
    },
    discountedPrice(product) {
      const price = product.price - (product.price * product.discount / 100)
      return price
    },
    // Display Unique Color
    Color(variants) {
      const uniqColor = []
      for (let i = 0; i < Object.keys(variants).length; i++) {
        if (uniqColor.indexOf(variants[i].color) === -1) {
          uniqColor.push(variants[i].color)
        }
      }
      return uniqColor
    },
    // add to cart
    addToCart: function (product, qty) {
      product.quantity = qty || 1
      this.$store.dispatch('cart/addToCart', product)
    },
    buyNow: function (product, qty) {
      product.quantity = qty || 1
      this.$store.dispatch('cart/addToCart', product)
      this.$router.push('/page/account/checkout')
    },
    // Item Count
    increment() {
      this.counter++
    },
    decrement() {
      if (this.counter > 1) this.counter--
    },
    // Change size variant
    changeSizeVariant(variant) {
      this.selectedSize = variant
    },
    getImgUrl(path) {
      return require('@/assets/images/' + path)
    },
    slideTo(id) {
      this.swiper.slideTo(id, 1000, false)
    },
    sizeVariant(id, slideId, color) {
      this.swiper.slideTo(slideId, 1000, false)
      this.size = []
      this.activeColor = color
      this.getDetail.variants.filter((item) => {
        if (id === item.image_id) {
          this.size.push(item.size)
        }
      })
    },
    clickFileForm() {
      if (this.editFlag) { this.$refs['file-input'].click() }
    },
    fetchCoordinate() {
      this.$axios.get('/api/v1/coordinates/' + this.$route.params.id + '/edit')
        .then(response => {
          this.coordinate = response.data.coordinate
          this.fetchItems()
        });
    },
    fetchItems() {
      this.coordinate.parts.forEach(part => {
        this.$axios.get('/api/v1/items/' + part.item_code).then(response => {
          part.params = response.data.params
        });
      })
    },
    changeItem(index, item_code) {
      this.coordinate.parts[index].item_code = item_code

      this.$axios.get('/api/v1/items/' + item_code).then(response => {
        this.coordinate.parts[index].params = response.data.params
        let rewardAmount = this.calculationRewardAmount(response.data)
        this.coordinate.parts[index].reward_amount = rewardAmount
      })
    },
    addItem(item_code) {
      this.$axios.get('/api/v1/items/' + item_code).then(response => {

        this.coordinate.parts.push(
          {
            item_code: item_code,
            params: response.data.params
          }
        )
      })
    },
    async updateCoordinate() {
      this.overlay = true
      try {
        await this.$axios.patch('/api/v1/coordinates/' + this.coordinate.id, this.coordinate)
        this.$localStorage.remove('coordinate')
        this.editFlag = false
        this.overlay = false
      } catch (error) {
        this.overlay = false
        console.log(error)
      }
    },
    editCoordinate() {
      this.$localStorage.set('coordinate', this.coordinate)
      this.editFlag = true
    },
    cancelEdit() {
      this.coordinate = this.$localStorage.get('coordinate')
      this.$localStorage.remove('coordinate')
      this.editFlag = false
    },
    onChangeFiles(event) {
      let input = this.$refs['file-input']
      this.uploadFiles(input.files)
      input.value = null
    },
    uploadFiles(files) {
      this.coordinate.images = []
      this.coordinate.blob_ids = []
      Array.from(files).forEach(file => this.uploadFile(file))
    },
    uploadFile(file) {
      const url = 'http://localhost:3000/rails/active_storage/direct_uploads'
      const directUploader = new DirectUploader(file, url, this._onUploadProgress.bind(this))
      directUploader.upload(this._onUploadError.bind(this), this._onUploadSuccess.bind(this))
    },
    _onUploadError(error, directUploader) {
      this.coordinate.images = []
      this.coordinate.blob_ids = []
      console.log(error)
    },
    _onUploadSuccess(blob, directUploader) {
      const endpoint = 'http://localhost:3000/rails/active_storage/blobs/redirect/'
      let signed_id = blob.signed_id
      let filename = blob.filename
      let image_url = endpoint + signed_id + '/' + filename
      this.coordinate.images.push(image_url)
      this.coordinate.blob_ids.push(blob.id)
    },
    _onUploadProgress(event, directUploader) {
    },
    draggableEnd(event) {
      this.coordinate.parts.forEach((part, index) => part.sort = index)
    },
    calculationRewardAmount(item) {
      let itemPrice = item.params.itemPrice
      let affiliateRate = item.params.affiliateRate
      return (itemPrice * affiliateRate * 0.01) / 50
    }
  }
}
</script>

<style>
  .btn-solid {
    border: none;
    background-image: none;
  }

  .product-wrapper-grid.list-view .product-box .product-detail h6 {
    width: 90%;
  }

  .product-box {
    margin-top: 10px;
  }
</style>