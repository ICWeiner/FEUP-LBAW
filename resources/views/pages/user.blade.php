@extends('layouts.app')

@section('content')
<div>
    {{ csrf_field() }}

    <label for="name">Name</label>
    <p id="name"  name="name">{{ Auth::user()->name }}
    
    <label for="email">E-Mail Address</label>
    <p id="email" name="email">{{ Auth::user()->email }}

    <a class="button" href="{{ url('/editUser') }}"><span>Edit Profile</span></a>
    
    <!-- Only for Admins --> 
    <a class="button" href="{{ url('/addShoes') }}"><span>Add Shoes</span></a>

    <p> {{ Auth::user()->address->address }} </p>
    <p> {{ Auth::user()->paymentInfo->card_number }} </p>

    <form method="GET" action="">
      <input type="submit" value="Order History" />
    </form>

</div>
@endsection
