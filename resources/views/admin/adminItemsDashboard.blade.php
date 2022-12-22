@extends('layouts.app')

@section('title', 'Store')

@section('content')


<div class="mb-5">
    <p class="lead fw-normal mb-1">Actions</p>
    <div class="p-4" style="background-color: #f8f9fa;">
    @if (Auth::user()->user_is_admin === true)
    <div class="mx-auto">
        <form method="GET" style="margin-bottom:1.5em"  action="{{ url('/addProduct') }}">
        <input class="btn btn-primary" type="submit" value="Add Product" />
        </form>
    </div>
    @endif
</div>



@endsection
