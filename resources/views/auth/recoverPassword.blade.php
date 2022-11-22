@extends('layouts.app')

@section('content')
<form method="POST" action="{{ route('recoverPassword') }}">
    {{ csrf_field() }}

    <label for="email">E-Mail Address</label>
    <input id="email" type="email" name="email" value="{{ old('email') }}" required>
    @if ($errors->has('email')===False)
      <span class="error">
          {{ $errors->first('email') }}
      </span>
    @endif
    
    <button type="submit">
      Change
    </button>
    <a class="button button-outline" href="{{ route('login') }}">Login</a>
</form>
@endsection
