@extends('layouts.app')

@section('title', $funkoPop->number_pop)

@section('content')
  @include('partials.shoe', ['shoe' => $shoe])
@endsection
