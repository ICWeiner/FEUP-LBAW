@extends('layouts.app')

@section('title', 'Store')

@section('content')

<section id="admin">
    <form method="GET" action="{{ url('/addShoes') }}">
        <input type="submit" value="Add Shoe" />
    </form>

    <form method="GET" action="{{ url('/addBooks') }}">
        <input type="submit" value="Add Shoe" />
    </form>

    <form method="GET" action="{{ url('/addFunkoPops') }}">
        <input type="submit" value="Add Shoe" />
    </form>

    <form method="GET" action="">
        <input type="submit" value="Edit Existing Product" />
    </form>
</section>

@endsection
