@extends('layouts.app')

@section('content')
<div class="vh-100 d-flex justify-content-center align-items-center">
        <div class="col-md-4 p-5 shadow-sm border rounded-5 border-primary">
            <h2 class="text-center mb-4 text-primary">Recover Password</h2>
                <form method="POST" action="{{ route('password.email') }}">
                    {{ csrf_field() }}
                    <!--email-->
                    <div class="mb-3">
                        <label for="exampleInputEmail1" class="form-label">E-mail Address</label>
                        <input type="email" name ="email" class="form-control bg-info bg-opacity-10 border border-primary" id="exampleInputEmail1" aria-describedby="emailHelp" required autofocus>
                        @if ($errors->has('msg'))
                            <span class="error">
                            {{ $errors->first('msg') }}
                            </span>
                        @endif
                    </div>
                    <div class="d-grid">
                      <button class="btn btn-primary" type="submit">Send recovery e-mail</button>
                    </div>
                </form>
                <div class="mt-3">
                    <a href="{{ route('login') }}" class="text-primary fw-bold text-decoration-none" > Login</a></p>
                </div>               
        </div>
    </div>
@endsection


