<template>
  <div>
    <Header />
    <Breadcrumbs title="Register" />
    <section class="register-page section-b-space">
      <div class="container">
        <div class="row">
          <div class="col-lg-12">
            <h3>{{title}}</h3>
            <div class="theme-card">
              <ValidationObserver v-slot="{ invalid }">
              <form class="theme-form" @submit.prevent="onSubmit">
                <!-- <div class="form-row">
                  <div class="col-md-6">
                    <label for="First name">First Name</label>
                    <ValidationProvider rules="required" v-slot="{ errors }" name="First name">
                    <input
                      type="text"
                      class="form-control"
                      id="First name"
                      v-model="fname"
                      placeholder="First Name"
                      name="First name"
                    />
                        <span class="validate-error">{{ errors[0] }}</span>
                      </ValidationProvider>
                  </div>
                  <div class="col-md-6">
                    <label for="lname">Last Name</label>
                    <ValidationProvider rules="required" v-slot="{ errors }" name="Last name">
                    <input
                      type="text"
                      class="form-control"
                      id="lname"
                      v-model="lname"
                      placeholder="Last Name"
                      name="lname"
                    />
                        <span class="validate-error">{{ errors[0] }}</span>
                      </ValidationProvider>
                  </div>
                </div> -->
                <div class="form-row">
                  <div class="col-md-6">
                    <label for="email">Email</label>
                    <ValidationProvider rules="required|email" v-slot="{ errors }" name="Email">
                  <input
                    type="email"
                    class="form-control"
                    id="email"
                    v-model="user.email"
                    placeholder="Email"
                    name="email"
                  />
                        <span class="validate-error">{{ errors[0] }}</span>
                      </ValidationProvider>
                  </div>
                </div>
                <div class="form-row">
                  <div class="col-md-6">
                    <label for="password">Password</label>
                    <ValidationProvider rules="required|confirmed:confirm" v-slot="{ errors }" name="password">
                    <input
                      type="password"
                      class="form-control"
                      id="password"
                      v-model="user.password"
                      placeholder="Enter your password"
                      name="password"
                    />
                        <span class="validate-error">{{ errors[0] }}</span>
                      </ValidationProvider>
                  </div>
                </div>
                <div class="form-row">
                  <div class="col-md-6">
                    <label for="password">Password confirmation</label>
                    <ValidationProvider vid="confirm" rules="required" v-slot="{ errors }" name="password_confirmation">
                    <input
                      type="password"
                      class="form-control"
                      id="password_confirmation"
                      v-model="user.password_confirmation"
                      placeholder="Enter your password confirmation"
                      name="password_confirmation"
                    />
                        <span class="validate-error">{{ errors[0] }}</span>
                      </ValidationProvider>
                  </div>
                </div>
                <div class="form-row">
                  <button
                    type="submit"
                    class="btn btn-solid mt-2"
                    :disabled="invalid"
                  >create account</button>
                </div>
              </form>
              </ValidationObserver>
            </div>
          </div>
        </div>
      </div>
    </section>
    <Footer />
  </div>
</template>
<script>
import { ValidationProvider, ValidationObserver } from 'vee-validate/dist/vee-validate.full.esm'
import Header from '../../../components/header/header1'
import Footer from '../../../components/footer/footer1'
import Breadcrumbs from '../../../components/widgets/breadcrumbs'
export default {
  auth: true,
  components: {
    Header,
    Footer,
    Breadcrumbs,
    ValidationProvider,
    ValidationObserver
  },
  data() {
    return {
      title: 'create account',
      user: {
        password: '',
        email: '',
        password_confirmation: '',
      },
    }
  },
  methods: {
    async onSubmit() {
      try {
        await this.$axios.post('/api/v1/auth', this.user)

        await this.$auth.loginWith('local', {
          data: {
            email: this.user.email,
            password: this.user.password,
          }
        })
        .then(
          (response) => {
            localStorage.setItem('access-token', response.headers['access-token'])
            localStorage.setItem('client', response.headers.client)
            localStorage.setItem('uid', response.headers.uid)
            localStorage.setItem('token-type', response.headers['token-type'])
            return response
          }
        )
      } catch (e) {
        this.error = e.response.data.message
      }
    }
  }
}
</script>
