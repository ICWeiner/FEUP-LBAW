@extends('layouts.app')

@section('content')
<div>
    {{ csrf_field() }}

    <label for="name">Name</label>
    <p id="name"  name="name">{{ Auth::user()->name }}
    
    <label for="email">E-Mail Address</label>
    <p id="email" name="email">{{ Auth::user()->email }}

    <a class="button" href="{{ url('/editUser') }}"><span>Edit Profile</span></a>

    <form method="GET" action="">
      <input type="submit" value="Order History" />
    </form>

</div>
@endsection
