@extends('layouts.app')

@section('title', 'Store')

@section('content')

<section id="admin">
    <form method="GET" action="{{ url('adminUsersDashboard') }}">
        <input type="submit" value="Admin User Area" />
    </form>

    <form method="GET" action="{{ url('adminItemsDashboard') }}">
        <input type="submit" value="Admin Product Area" />
    </form>
</section>

@endsection
