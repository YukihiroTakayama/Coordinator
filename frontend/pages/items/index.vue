<template>
  <div>
    <Header />
    <Breadcrumbs title="collection" />
    <section class="section-b-space ratio_asos">
      <div class="collection-wrapper">
        <div class="container">
          <div class="row">
            <div class="col-lg-3">
              <div>
               <div class="row">
                  <div class="col-xl-12">
                    <div class="filter-main-btn"  @click="filter = !filter">
                      <span class="filter-btn btn btn-theme">
                        <i class="fa fa-filter" aria-hidden="true"></i> Filter
                      </span>
                    </div>
                  </div>
                </div>
                  <div class="collection-filter" :class="{ 'openFilterbar' : filter }">
                  <div class="collection-filter-block">
                    <div class="input-group">
                      <input
                        type="text"
                        class="form-control"
                        v-model="search_params.keyword"
                      >
                    </div>
                  </div>
                   <div class="collection-filter-block">
                    <!-- brand filter start -->
                    <div class="collection-mobile-back">
                      <span class="filter-back" @click="filter = !filter">
                        <i class="fa fa-angle-left" aria-hidden="true"></i> back
                      </span>
                    </div>
                    <div class="collection-collapse-block open">
                     <h3 class="collapse-block-title" v-b-toggle.category>Category</h3>
                      <b-collapse id="category" visible accordion="myaccordion" role="tabpanel">
                        <div class="collection-collapse-block-content">
                        <div class="collection-brand-filter">
                          <ul class="category-list">
                            <li
                            v-for="(category, index) in categories"
                            :key="index">
                              <a href="javascript:void(0)" @click.prevent="search_params.genre_id = category.id">
                                {{ category.name }}
                              </a>
                            </li>
                          </ul>
                        </div>
                      </div>
                    </b-collapse>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="collection-content col">
              <div class="page-main-content">
                <div class="row">
                  <div class="col-sm-12">
                    <!-- <div class="top-banner-wrapper">
                      <a href="#">
                        <img
                          :src='"@/assets/images/mega-menu/2.jpg"'
                          class="img-fluid"
                          alt
                        />
                      </a>
                      <div class="top-banner-content small-section">
                        <h4>fashion</h4>
                        <h5>Lorem Ipsum is simply dummy text of the printing and typesetting industry.</h5>
                        <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>
                      </div>
                    </div> -->
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
                                <h5>Showing Products 1-12 of {{ items.length }} Result</h5>
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
                          <div class="col-sm-12">
                            <div class="text-center section-t-space section-b-space" v-if="items.length == 0">
                              <img :src='"@/assets/images/empty-search.jpg"' class="img-fluid" alt />
                              <h3 class="mt-3">Sorry! Couldn't find the product you were looking For!!!</h3>
                              <div class="col-12 mt-3">
                                  <nuxt-link :to="{ path: '/'}" class="btn btn-solid">continue shopping</nuxt-link>
                              </div>
                            </div>
                          </div>
                          <div
                          class="col-grid-box"
                          :class="{'col-lg-3':col4 == true, 'col-lg-4':col3 == true, 'col-lg-6':col2 == true, 'col-lg-2':col6 == true, 'col-lg-12':listview == true}"
                          v-for="(item,index) in items"
                          :key="index"
                          v-show="setPaginate(index)"
                          >
                            <div class="product-box">
                              <productBox1
                                @opencartmodel="showCart"
                                @showCompareModal="showCoampre"
                                @openquickview="showQuickview"
                                @showalert="alert"
                                @alertseconds="alert"
                                :product="item.params"
                                :index="index"
                              />
                            </div>
                          </div>
                        </div>
                      </div>
                      <div class="product-pagination mb-0" v-if="items.length > this.paginate">
                        <div class="theme-paggination-block">
                          <div class="row">
                            <div class="col-xl-6 col-md-6 col-sm-12">
                              <nav aria-label="Page navigation">
                                <ul class="pagination">
                                  <li class="page-item" :class="{'disable': current == 1 }">
                                    <a class="page-link" href="javascript:void(0)" @click="updatePaginate(current-1)">
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
                                  <li class="page-item" :class="{'disable': current == this.paginates }">
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
                                <h5>Showing Products 1-12 of {{ items.length }} Result</h5>
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
    <cartModel :openCart="showcartmodal" :productData="cartproduct" @closeCart="closeCartModal" :products="items" />
    <Footer />
  </div>
</template>
<script>
import { mapGetters } from 'vuex'
import productBox1 from '../../components/product-box/product-box'
import Header from '../../components/header/header1'
import Footer from '../../components/footer/footer1'
import Breadcrumbs from '../../components/widgets/breadcrumbs'
import sidebar from '../../components/widgets/collection-sidebar'
import quickviewModel from '../../components/widgets/quickview'
import compareModel from '../../components/widgets/compare-popup'
import cartModel from '../../components/cart-model/cart-modal-popup'
import axios from 'axios'
export default {
  components: {
    Header,
    Footer,
    Breadcrumbs,
    productBox1,
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
      col4: true,
      col6: false,
      listview: false,
      priceArray: [],
      allfilters: [],
      items: [],
      current: 1,
      paginate: 12,
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
      categories: [],
      search_params: {
        keyword: '',
        genre_id: 100433,
        image_flag: 1
      }
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
    this.fetchCategories()
    this.fetchItems()
    this.updatePaginate(1)
  },
  watch: {
    search_params: {
      handler: function (val, oldVal) {
        this.fetchItems()
      },
      deep: true
    }
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
    fetchCategories() {
      axios.get('/api/v1/genres').then(response => {
        this.categories = response.data
      })
    },
    fetchItems() {
      axios.get('/api/v1/items', {
        params: this.search_params
      }).then(response => {
        this.items = response.data
      })
    }
  }
}
</script>
