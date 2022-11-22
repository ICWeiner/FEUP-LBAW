@extends('layouts.app')

@section('title', $user->id_user)

@section('content')
  @include('partials.orders', ['user' => $user])
@endsection
