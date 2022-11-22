@extends('layouts.app')

@section('content')
<div>
    {{ csrf_field() }}

    <label for="name">Name</label>
    <p id="name"  name="name">{{ Auth::user()->name }}

    <label for="email">E-Mail Address</label>
    <p id="email" name="email">{{ Auth::user()->email }}

    <!-- Only for Admins --> 
    <a class="button" href="{{ url('/addShoes') }}"><span>Add Shoes</span></a>
    <a class="button" href="{{ url('/addBooks') }}"><span>Add Book</span></a>
    <a class="button" href="{{ url('/addFunkoPops') }}"><span>Add FunkoPop</span></a>

    <form method="GET" action="{{ url('/editUser') }}">
        <input type="submit" value="Edit Profile" />
      </form>


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
