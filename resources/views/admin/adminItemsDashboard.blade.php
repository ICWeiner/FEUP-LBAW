@extends('layouts.app')

@section('title', 'Store')

@section('content')

<section id="admin">
    <form method="GET" action="">
        <input type="submit" value="Add Product" />
    </form>

    <form method="GET" action="">
        <input type="submit" value="Edit Existing Product" />
    </form>
</section>

@endsection
