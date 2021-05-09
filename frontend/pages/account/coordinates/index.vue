<template>
  <div>
    <Header />
    <Breadcrumbs title="collection" />
    <section class="section-b-space ratio_asos">
      <div class="collection-wrapper">
        <div class="container">
          <div class="row">
            <div class="collection-content col">
              <div class="page-main-content">
                <div class="row">
                  <div class="col-sm-12">
                    <ul class="product-filter-tags">
                      <li
                      class="mr-1"
                      v-for="(tag,index) in allfilters"
                      :key="index">
                      <a href="javascript:void(0)" class="filter_tag">{{tag}}<i class="ti-close" @click="removeTags(tag)"></i></a>
                      </li>
                      <li class="clear_filter" v-if="allfilters.length > 0"><a href="javascript:void(0)" class="clear_filter" @click="removeAllTags()">Clear all</a></li>
                    </ul>
                    <div class="collection-product-wrapper">
                      <div class="product-top-filter">
                        <div class="row">
                          <div class="col-12">
                            <div class="product-filter-content">
                              <div class="search-count">
                                <h5>Showing Products 1-6 of {{ coordinates.length }} Result</h5>
                              </div>
                              <div class="collection-view">
                                <ul>
                                  <li @click="gridView()">
                                    <i class="fa fa-th grid-layout-view"></i>
                                  </li>
                                  <li @click="listView()">
                                    <i class="fa fa-list-ul list-layout-view"></i>
                                  </li>
                                </ul>
                              </div>
                              <div class="collection-grid-view">
                                <ul>
                                  <li>
                                    <img
                                      :src='"@/assets/images/icon/2.png"'
                                      @click="grid2()"
                                      class="product-2-layout-view"
                                    />
                                  </li>
                                  <li>
                                    <img
                                      :src='"@/assets/images/icon/3.png"'
                                      @click="grid3()"
                                      class="product-3-layout-view"
                                    />
                                  </li>
                                  <li>
                                    <img
                                      :src='"@/assets/images/icon/4.png"'
                                      @click="grid4()"
                                      class="product-4-layout-view"
                                    />
                                  </li>
                                  <li>
                                    <img
                                      :src='"@/assets/images/icon/6.png"'
                                      @click="grid6()"
                                      class="product-6-layout-view"
                                    />
                                  </li>
                                </ul>
                              </div>
                              <div class="product-page-filter">
                                <select @change="onChangeSort($event)">
                                  <option value="all">Sorting Items</option>
                                  <option value="a-z">Alphabetically, A-Z</option>
                                  <option value="z-a">Alphabetically, Z-A</option>
                                  <option value="low">price, low to high</option>
                                  <option value="high">price, high to low</option>
                                </select>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                      <div class="product-wrapper-grid" :class="{'list-view':listview == true}">
                        <div class="row">
                          <div
                          class="col-grid-box"
                          :class="{'col-lg-3 col-md-4 col-sm-6':col4 == true, 'col-lg-4 col-sm-6':col3 == true, 'col-sm-6':col2 == true, 'col-lg-2 col-md-4 col-sm-6':col6 == true, 'col-lg-12':listview == true}"
                          v-for="(coordinate, index) in coordinates"
                          :key="index"
                          v-if="!coordinate.is_deleted"
                          >
                            <div class="product-box">
                              <coordinateBox
                                @opencartmodel="showCart"
                                @showCompareModal="showCoampre"
                                @openquickview="showQuickview"
                                @showalert="alert"
                                @alertseconds="alert"
                                :product="coordinate"
                                :index="index"
                              />

                              <div style="display: block; align-self: center; margin-left: auto;">
                                <button
                                  class="btn btn-solid btn-success"
                                  title="Show"
                                  style="display: block; width: 100%;"
                                  @click="$router.push('/account/coordinates/' + '1')"
                                >Show</button>
                                <button
                                  class="btn btn-solid btn-danger"
                                  title="Save"
                                  @click="coordinate.is_deleted = true"
                                  style="display: block; width: 100%;"
                                >Delete</button>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                      <div class="product-pagination mb-0" v-if="coordinates.length > this.paginate">
                        <div class="theme-paggination-block">
                          <div class="row">
                            <div class="col-xl-6 col-md-6 col-sm-12">
                              <nav aria-label="Page navigation">
                                <ul class="pagination">
                                  <li class="page-item">
                                    <a class="page-link" href="javascript:void(0)"  @click="updatePaginate(current-1)">
                                      <span aria-hidden="true">
                                        <i class="fa fa-chevron-left" aria-hidden="true"></i>
                                      </span>
                                    </a>
                                  </li>
                                  <li class="page-item" v-for="(page_index, index) in this.pages" :key="index" :class="{'active': page_index == current}">
                                    <a
                                      class="page-link"
                                      href="javascrip:void(0)"
                                      @click.prevent="updatePaginate(page_index)"
                                    >{{ page_index }}</a>
                                  </li>
                                  <li class="page-item">
                                    <a class="page-link" href="javascript:void(0)" @click="updatePaginate(current+1)">
                                      <span aria-hidden="true">
                                        <i class="fa fa-chevron-right" aria-hidden="true"></i>
                                      </span>
                                    </a>
                                  </li>
                                </ul>
                              </nav>
                            </div>
                            <div class="col-xl-6 col-md-6 col-sm-12">
                              <div class="product-search-count-bottom">
                                <h5>Showing Products 1-6 of {{ coordinates.length }} Result</h5>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <b-alert
      :show="dismissCountDown"
      variant="success"
      @dismissed="dismissCountDown=0"
      @dismiss-count-down="alert"
    >
      <p>Product Is successfully added to your wishlist.</p>
    </b-alert>
    <quickviewModel :openModal="showquickviewmodel" :productData="quickviewproduct" />
    <compareModel :openCompare="showcomparemodal" :productData="comapreproduct" @closeCompare="closeCompareModal" />
    <cartModel :openCart="showcartmodal" :productData="cartproduct" @closeCart="closeCartModal" :products="coordinates" />
    <Footer />
  </div>
</template>
<script>
import { mapGetters } from 'vuex'
import coordinateBox from '../../../components/widgets/coordinate-box'
import Header from '../../../components/header/header1'
import Footer from '../../../components/footer/footer1'
import Breadcrumbs from '../../../components/widgets/breadcrumbs'
import sidebar from '../../../components/widgets/collection-sidebar'
import quickviewModel from '../../../components/widgets/quickview'
import compareModel from '../../../components/widgets/compare-popup'
import cartModel from '../../../components/cart-model/cart-modal-popup'
import coordinates from '../../../data/coordinates'

export default {
  components: {
    Header,
    Footer,
    Breadcrumbs,
    coordinateBox,
    sidebar,
    quickviewModel,
    compareModel,
    cartModel
  },
  data() {
    return {
      bannerimagepath: require('@/assets/images/side-banner.png'),
      col2: false,
      col3: false,
      col4: false,
      col6: false,
      listview: true,
      priceArray: [],
      allfilters: [],
      items: [],
      current: 1,
      paginate: 6,
      paginateRange: 3,
      pages: [],
      paginates: '',
      showquickviewmodel: false,
      showcomparemodal: false,
      showcartmodal: false,
      quickviewproduct: {},
      comapreproduct: {},
      cartproduct: {},
      dismissSecs: 5,
      dismissCountDown: 0,
      swiperOption: {
        loop: false,
        navigation: {
          nextEl: '.swiper-button-next',
          prevEl: '.swiper-button-prev'
        }
      },
      coordinates: [],
    }
  },
  computed: {
    ...mapGetters({
      filterProduct: 'filter/filterProducts',
      tags: 'filter/setTags',
      curr: 'products/changeCurrency'
    })
  },
  mounted() {
    this.updatePaginate(1)
    this.fetchCoordinates()
  },
  methods: {
    onChangeSort(event) {
      this.$store.dispatch('filter/sortProducts', event.target.value)
    },
    gridView() {
      this.col4 = true
      this.col2 = false
      this.col3 = false
      this.col6 = false
      this.listview = false
    },
    listView() {
      this.listview = true
      this.col4 = false
      this.col2 = false
      this.col3 = false
      this.col6 = false
    },
    grid2() {
      this.col2 = true
      this.col3 = false
      this.col4 = false
      this.col6 = false
      this.listview = false
    },
    grid3() {
      this.col3 = true
      this.col2 = false
      this.col4 = false
      this.col6 = false
      this.listview = false
    },
    grid4() {
      this.col4 = true
      this.col2 = false
      this.col3 = false
      this.col6 = false
      this.listview = false
    },
    grid6() {
      this.col6 = true
      this.col2 = false
      this.col3 = false
      this.col4 = false
      this.listview = false
    },
    removeTags(val) {
      this.allfilters.splice(this.allfilters.indexOf(val), 1)
    },
    removeAllTags() {
      this.allfilters.splice(0, this.allfilters.length)
    },
    getCategoryFilter() {
      this.updatePaginate(1)
      this.$store.dispatch('filter/getCategoryFilter', this.$route.params.id)
    },
    allfilter(selectedVal) {
      this.allfilters = selectedVal
      this.$store.dispatch('filter/setTags', selectedVal)
      this.getPaginate()
      this.updatePaginate(1)
    },
    pricefilterArray(item) {
      this.getCategoryFilter()
      this.$store.dispatch('filter/priceFilter', item)
      this.getPaginate()
      this.updatePaginate(1)
    },
    getPaginate() {
      this.paginates = Math.round(this.filterProduct.length / this.paginate)
      this.pages = []
      for (let i = 0; i < this.paginates; i++) {
        this.pages.push(i + 1)
      }
    },
    setPaginate(i) {
      if (this.current === 1) {
        return i < this.paginate
      } else {
        return (i >= (this.paginate * (this.current - 1)) && i < (this.current * this.paginate))
      }
    },
    updatePaginate(i) {
      this.current = i
      let start = 0
      let end = 0
      if (this.current < this.paginateRange - 1) {
        start = 1
        end = start + this.paginateRange - 1
      } else {
        start = this.current - 1
        end = this.current + 1
      }
      if (start < 1) {
        start = 1
      }
      if (end > this.paginates) {
        end = this.paginates
      }
      this.pages = []
      for (let i = start; i <= end; i++) {
        this.pages.push(i)
      }
      return this.pages
    },
    alert(item) {
      this.dismissCountDown = item
    },
    showQuickview(item, productData) {
      this.showquickviewmodel = item
      this.quickviewproduct = productData
    },
    showCoampre(item, productData) {
      this.showcomparemodal = item
      this.comapreproduct = productData
    },
    closeCompareModal(item) {
      this.showcomparemodal = item
    },
    showCart(item, productData) {
      this.showcartmodal = item
      this.cartproduct = productData
    },
    closeCartModal(item) {
      this.showcartmodal = item
    },
    fetchCoordinates() {
      this.$axios.get('api/v1/coordinates', {
        headers: this.$localStorage.get('headers'),
      }).then(response => {
        // this.coordinates = response.data
        this.coordinates = coordinates.data
        this.fetchItems()
      })
    },
    fetchItems() {
      this.coordinates.forEach(coordinate => {
        coordinate.parts.forEach(part => {
          this.$axios.get('/api/v1/items/' + part.item_code).then(response => {
            part.params = response.data.params
          });
        })
      })
    },
  }
}
</script>

<style>
  .product-wrapper-grid.list-view .product-box .img-wrapper {
    width: 10%;
  }
</style>
