@extends('layouts.app')

@section('content')
  <section class="h-100 gradient-custom-2">
    <form action="{{ url('/editUser') }}">
      <div class="container py-5 h-100">
        <div class="row d-flex justify-content-center align-items-center h-100">
          <div class="col col-lg-9 col-xl-7">
            <div class="card">
              <div class="rounded-top text-white d-flex flex-row" style="background-color: #21325e; height:200px;">
                <div class="ms-4 mt-6 d-flex flex-column" style="width: 150px;">
                  {{ csrf_field() }}
                  
                  @if ($user->image === null)
                    <img src="images/users/placeholder_user.png" alt="Generic placeholder image" class="img-fluid img-thumbnail mt-4 mb-2" style="width: 150px; z-index: 1">
                  @else
                    <img src="{{ $user->image }}" alt="User profile image" class="img-fluid img-thumbnail mt-4 mb-2" style="width: 150px; z-index: 1">
                  @endif
                  <button type="submit" href="{{ url('/editUser') }}" class="btn btn-outline-dark" data-mdb-ripple-color="dark" style="z-index: 1 ;margin-top: 29px;">
                      Edit profile
                  </button>
                </div>
    </form>
              <div class="ms-3" style="margin-top: 130px;">
                <h5 id="name"  name="name">{{ Auth::user()->name }}</h5>
                <p id="email" name="email">{{ Auth::user()->email }}</p>
              </div>
            </div>

            <div class="p-4 text-black" style="background-color: #f8f9fa;">
              <div class="d-flex justify-content-end text-center py-1">
                <div>
                  <p class="mb-1 h5"></p>
                  <p class="small text-muted mb-0"></p>
                </div>
                <div class="px-3">
                  <p class="mb-1 h5"></p>
                  <p class="small text-muted mb-0"></p>
                </div>
                <div>
                  <p class="mb-1 h5"></p>
                  <p class="small text-muted mb-0"></p>
                </div>
              </div>
            </div>
            
            <div class="card-body p-4 text-black">
              <div class="mb-5">
                <p class="lead fw-normal mb-1">About</p>
                <div class="p-4" style="background-color: #f8f9fa;">
                  @isset(Auth::user()->address->address)
                  <p>{{ Auth::user()->address->address }} </p>
                  @else
                  <p> No addresses found</p>
                  @endisset

                  @isset(Auth::user()->paymentInfo->card_number)
                  <p>{{ Auth::user()->paymentInfo->card_number }} </p>
                  @else
                  <p> no payment methods found</p>
                  @endisset
                </div>
              </div>

              <div class="d-flex justify-content-between align-items-center mb-4">
                <p class="lead fw-normal mb-0">Recent Orders</p>
                <form method="GET" action="{{ url('/showOrders') }}">
                  <input class="btn btn-primary" type="submit" value="Order History" />
                </form>
              </div>
              
              <div class="row g-2">
                <div class="col">
                  <img alt="Generic placeholder image" src="https://mdbcdn.b-cdn.net/img/Photos/Lightbox/Original/img%20(108).webp"
                    alt="image 1" class="w-100 rounded-3">
                </div>
                <div class="col">
                  <img alt="Generic placeholder image" src="https://mdbcdn.b-cdn.net/img/Photos/Lightbox/Original/img%20(114).webp"
                    alt="image 1" class="w-100 rounded-3">
                </div>
              </div>

                <div class="mb-5">
                  <p class="lead fw-normal mb-1">Actions</p>
                  <div class="p-4" style="background-color: #f8f9fa;">
                  
                    <div class="mx-auto">
                      <form method="GET" style="margin-bottom:1.5em"  action="{{ url('/deleteUser') }}">
                        <input class="btn btn-primary" type="submit" value="Delete Account" />
                      </form>
                    </div>

                    <div class="mx-auto">  
                      @if (Auth::user()->user_is_admin === true)
                        <div class="d-grid">
                          <form method="GET" action="{{ url('adminDashboard') }}">
                            <input class="btn btn-primary" type="submit" value="Administration Area" />
                          </form>
                        </div>
                      @endif
                    </div>
                  </div>
                </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
@endsection