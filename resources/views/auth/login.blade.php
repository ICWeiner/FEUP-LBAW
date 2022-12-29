@extends('layouts.app')

@section('content')
    <div class="vh-100 d-flex justify-content-center align-items-center">
        <div class="col-md-4 p-5 shadow-sm border rounded-5 border-primary">
            <h2 class="text-center mb-4 text-primary">Login</h2>
                <form method="POST" action="{{ route('login') }}">
                    {{ csrf_field() }}
                    <!--email-->
                    <div class="mb-3">
                        <label for="exampleInputEmail1" class="form-label">E-mail Address</label>
                        <input type="email" name ="email" class="form-control bg-info bg-opacity-10 border border-primary" id="exampleInputEmail1" aria-describedby="emailHelp" required autofocus>
                        <div id="emailHelp" class="form-text">We'll never share your email with anyone else.</div>
                        @if ($errors->has('email'))
                            <span class="error">
                            {{ $errors->first('email') }}
                            </span>
                        @endif
                    </div>

                    <!--password-->
                    <div class="mb-3">
                        <label for="exampleInputPassword1" class="form-label">Password</label>
                        <input type="password" class="form-control bg-info bg-opacity-10 border border-primary" id="exampleInputPassword1" name="password" required>
                        @if ($errors->has('password'))
                            <span class="error">
                                {{ $errors->first('password') }}
                            </span>
                        @endif
                    </div>

                    <!--remeber me-->
                    <!--<div class="mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="exampleCheck1" name="remember" {{ old('remember') ? 'checked' : '' }}>
                        <label class="form-check-label" for="exampleCheck1">Remember me</label>
                    </div>-->

                    <p class="small"><a class="text-decoration-none" href="{{ route('password.email') }}">Recover Password</a></p>

                    <div class="d-grid">
                        <button class="btn btn-primary" type="submit">Login</button>
                    </div>
                </form>
                <div class="mt-3">
                    <p class="mb-0  text-center">Don't have an account?<a href="{{ route('register') }}" class="text-primary fw-bold text-decoration-none" > Sign Up</a></p>
                </div>               
        </div>
    </div>
@endsection