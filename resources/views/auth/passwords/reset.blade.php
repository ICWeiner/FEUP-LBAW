@extends('layouts.app')

@section('content')

<div class="vh-100 d-flex justify-content-center align-items-center">
  <div class="col-md-4 p-5 shadow-sm border rounded-5 border-primary">
    <h2 class="text-center mb-4 text-primary">Reset Password</h2>
      <form method="POST" action="{{ route('password.update') }}" >
          {{ csrf_field() }}

          <input name="email" value="{{  Request::get('email') }}" required hidden>
          <!--password-->
          <div class="mb-3">
            <label for="password" class="form-label">New Password</label>
            <input type="password" name="password" class="form-control bg-info bg-opacity-10 border border-primary" id="password" required>
            @if ($errors->has('email'))
              <span class="error">
                  {{ $errors->first('email') }}
              </span>
            @endif
          </div>
          <!--conf password-->
          <div class="mb-3">
            <label for="password_confirmation" class="form-label">Confirm Password</label>
            <input type="password" name="password_confirmation" class="form-control bg-info bg-opacity-10 border border-primary" id="password_confirmation" required>
          </div>

          
            
          <div class="d-grid">
            <button class="btn btn-primary" type="submit">Submit</button>
          </div>
      </form>

      <div class="mt-3">
        <p class="mb-0  text-center"><a href="{{ route('login') }}" class="text-primary fw-bold text-decoration-none"> Login</a></p>
      </div>     

  </div>
</div>
@endsection