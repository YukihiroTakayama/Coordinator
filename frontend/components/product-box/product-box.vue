<template>
  <div>
    <!-- {{ product }} -->
    <div class="img-wrapper">
      <div class="lable-block">
        <!-- <span class="lable3" v-if="product.new">new</span>
        <span class="lable4" v-if="product.sale">on sale</span> -->
      </div>
      <div class="front">
        <a href="javascript:void(0);">
          <img
            :src="imageSrc"
            :id="product.code"
            class="img-fluid bg-img"
            :alt="product.name"
            :key="index"
            height="128"
            style="max-height: 128px; max-width: 128px; margin-left: 25%;"
          />
        </a>
      </div>
      <ul class="product-thumb-list">
        <li
          class="grid_thumb_img"
          :class="{active: imageSrc === image}"
          v-for="(image, index) in product.mediumImageUrls"
          :key="index"
          @click="productVariantChange(image)"
        >
          <a href="javascript:void(0);">
            <img :src="image" height="40" width="40" />
          </a>
        </li>
      </ul>
    </div>
    <div class="product-detail">
      <div class="rating">
        <i v-for="n of product.reviewAverage" :key="n" class="fa fa-star" style="color: #ffa200;"></i>
        <i v-for="n of (5 - product.reviewAverage)" :key="n" class="fa fa-star" style="color: #dddddd;"></i>
      </div>
      <a href="javascript:void(0);">
        <h6>{{ product.itemName }}</h6>
      </a>
      <!-- <p>{{ product.itemCaption }}</p> -->
      <h4>
        {{ '￥' + product.itemPrice }}
      </h4>
    </div>
  </div>
</template>

<script>
import { mapState, mapGetters } from 'vuex'
import { log } from 'util'
export default {
  props: {
    index: {
      type     : Number,
      require  : false,
    },
    product: {
      type     : Object,
      require  : false,
      'default': () => ({
        mediumImageUrls: []
      })
    },
  },
  data() {
    return {
      imageSrc: '',
      quickviewProduct: {},
      compareProduct: {},
      cartProduct: {},
      showquickview: false,
      showCompareModal: false,
      cartval: false,
      variants: {
        productId: '',
        image: ''
      },
      dismissSecs: 5,
      dismissCountDown: 0
    }
  },
  computed: {
    ...mapState({
      productslist: state => state.products.productslist
    }),
    ...mapGetters({
      curr: 'products/changeCurrency'
    })
  },
  mounted() {
    this.imageSrc = this.product.mediumImageUrls ? this.product.mediumImageUrls[0] : ''
  },
  watch: {
    product: {
      handler: function (val, oldVal) {
        this.imageSrc = this.product.mediumImageUrls ? this.product.mediumImageUrls[0] : ''
      },
      deep: true
    }
  },
  methods: {
    getImgUrl(path) {
      return require('@/assets/images/' + path)
    },
    addToCart: function (product) {
      this.cartval = true
      this.cartProduct = product
      this.$emit('opencartmodel', this.cartval, this.cartProduct)
      this.$store.dispatch('cart/addToCart', product)
    },
    addToWishlist: function (product) {
      this.dismissCountDown = this.dismissSecs
      this.$emit('showalert', this.dismissCountDown)
      this.$store.dispatch('products/addToWishlist', product)
    },
    showQuickview: function (productData) {
      this.showquickview = true
      this.quickviewProduct = productData
      this.$emit('openquickview', this.showquickview, this.quickviewProduct)
    },
    addToCompare: function (product) {
      this.showCompareModal = true
      this.compareProduct = product
      this.$emit('showCompareModal', this.showCompareModal, this.compareProduct)
      this.$store.dispatch('products/addToCompare', product)
    },
    Color(variants) {
      const uniqColor = []
      // for (let i = 0; i < Object.keys(variants).length; i++) {
      //   if (uniqColor.indexOf(variants[i].color) === -1) {
      //     uniqColor.push(variants[i].color)
      //   }
      // }
      return uniqColor
    },
    productColorchange(color, product) {
      product.variants.map((item) => {
        if (item.color === color) {
          product.images.map((img) => {
            if (img.image_id === item.image_id) {
              this.imageSrc = img.src
            }
          })
        }
      })
    },
    productVariantChange(imgsrc) {
      console.log("I am calll");      
      this.imageSrc = imgsrc
    },
    countDownChanged(dismissCountDown) {
      this.dismissCountDown = dismissCountDown
      this.$emit('alertseconds', this.dismissCountDown)
    },
    discountedPrice(product) {
      const price = product.price - (product.price * product.discount / 100)
      return price
    }
  }
}
</script>
