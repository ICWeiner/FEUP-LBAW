@extends('layouts.app')

@section('content')
<div>
    {{ csrf_field() }}

    <label for="name">Name</label>
    <p id="name"  name="name">{{ Auth::user()->name }}

    <label for="email">E-Mail Address</label>
    <p id="email" name="email">{{ Auth::user()->email }}

    <form method="GET" action="{{ url('/editUser') }}">
        <input type="submit" value="Edit Profile" />
      </form>

    <form method="GET" action="">
      <input type="submit" value="Order History" />
    </form>

    @if (Auth::user()->user_is_admin === true)
        <form method="GET" action="{{ url('adminDashboard') }}">
            <input type="submit" value="Administration Area" />
        </form>
    @endif

</div>
@endsection
