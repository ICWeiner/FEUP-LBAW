@extends('layouts.app')

@section('content')
<div class="vh-100 d-flex justify-content-center align-items-center">
        <div class="col-md-4 p-5 shadow-sm border rounded-5 border-primary">
            <h2 class="text-center mb-4 text-primary">Login</h2>
                <form method="POST" action="{{ route('adminEditUser') }}">
                    {{ csrf_field() }}
                    <!--email-->
                    <div class="mb-3">
                    <label for="name" class="form-label">New name</label>
                        <input name="id_user" value="{{  Request::get('id_user') }}" required hidden>
                        <input type="text" name="name" value="{{ old('name') }}" class="form-control bg-info bg-opacity-10 border border-primary" id="name" aria-describedby="name" pattern="[a-zA-Z0-9]+[a-zA-Z0-9 ]+" required autofocus>
                        </span>
                    </div>
                    <div class="d-grid">
                        <button class="btn btn-primary" type="submit">Change name</button>
                    </div>
                </form>          
        </div>
    </div>
@endsection
