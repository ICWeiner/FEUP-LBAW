@extends('layouts.app')

@section('content')

<div class="vh-100 d-flex justify-content-center align-items-center">
  <div class="col-md-4 p-5 shadow-sm border rounded-5 border-primary">
    <h2 class="text-center mb-4 text-primary">Register</h2>
      <form method="POST" action="{{ route('register') }}">
          {{ csrf_field() }}
          <!--name-->
          <div class="mb-3">
            <label for="name" class="form-label">Name</label>
            <input type="text" name="name" class="form-control bg-info bg-opacity-10 border border-primary" id="name" aria-describedby="name" pattern="[a-zA-Z0-9]+[a-zA-Z0-9 ]+" required autofocus>
            @if ($errors->has('name'))
              <span class="error">
                  {{ $errors->first('name') }}
              </span>
            @endif
          </div>
          <!--email-->
          <div class="mb-3">
            <label for="email" class="form-label">E-mail Address</label>
            <input type="email" name="email" class="form-control bg-info bg-opacity-10 border border-primary" id="email" aria-describedby="emailHelp" required>
            @if ($errors->has('email'))
              <span class="error">
                  {{ $errors->first('email') }}
              </span>
            @endif
          </div>
          <!--password-->
          <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" name="password" class="form-control bg-info bg-opacity-10 border border-primary" id="password" required>
            @if ($errors->has('password'))
              <span class="error">
                  {{ $errors->first('password') }}
              </span>
            @endif
          </div>
          <!--conf password-->
          <div class="mb-3">
            <label for="password_confirmation" class="form-label">Confirm Password</label>
            <input type="password" name="password_confirmation" class="form-control bg-info bg-opacity-10 border border-primary" id="password_confirmation" required>
          </div>
            
          <div class="d-grid">
            <button class="btn btn-primary" type="submit">Register</button>
          </div>
      </form>

      <div class="mt-3">
        <p class="mb-0  text-center">Already have an account?<a href="{{ route('login') }}" class="text-primary fw-bold text-decoration-none"> Login</a></p>
      </div>     

  </div>
</div>
@endsection



  <!--
        <div class="vh-100 d-flex justify-content-center align-items-center">
            <div class="col-md-4 p-5 shadow-sm border rounded-5 border-primary">
                <h2 class="text-center mb-4 text-primary">Login Form</h2>
                <form>
                    <div class="mb-3">
                        <label for="exampleInputEmail1" class="form-label">Email address</label>
                        <input type="email" class="form-control bg-info bg-opacity-10 border border-primary" id="exampleInputEmail1" aria-describedby="emailHelp">
                    </div>
                    <div class="mb-3">
                        <label for="exampleInputPassword1" class="form-label">Password</label>
                        <input type="password" class="form-control bg-info bg-opacity-10 border border-primary" id="exampleInputPassword1">
                    </div>
                    <p class="small"><a class="text-primary" href="forget-password.html">Forgot password?</a></p>
                    <div class="d-grid">
                        <button class="btn btn-primary" type="submit">Login</button>
                    </div>
                </form>
                <div class="mt-3">
                    <p class="mb-0  text-center">Don't have an account? <a href="signup.html"
                            class="text-primary fw-bold">Sign
                            Up</a></p>
                </div>
            </div>
        </div>-->
