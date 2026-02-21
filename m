Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E1C22425B;
	Sat, 21 Feb 2026 17:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771696390; cv=none; b=pLwfJjB1YkBDG+ErykUWxoaUoATJ8yKqxbJYA7bHuAZiIBzzCZe3Kjp1zkQSIaWpaX9WCJRKhfPwfTRZW0t+ZkMA2LQsmjiHLK6IygTUMzeMwtmCBimmPxz0EUVJ2CtDh1+p8He8AnNBNjCnnUWgVsu2Yazzt55CAyBLlcAf3qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771696390; c=relaxed/simple;
	bh=4BYAjfutBgHEtEvj+89FxAxvHBlXzUC86KJQUoWFQsA=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=tF6Kh0sgFvXW5/LQ0fv//BjZE10Rh6Vl+mm9icuHOBNOlaWf+Po5guEtZJVx3rNrGPS+KxZlo32qDXUylhMB4TeY9Zw4IEvr6mUg3viRP0g6aQQC6WpkRNvOsPqVMm11E+DtKq3e5X0Na3HY1HHnjTe8qwvfVaN6ZkbGq/LXx7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boe4deqy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boe4deqy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C40C4CEF7;
	Sat, 21 Feb 2026 17:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771696389;
	bh=4BYAjfutBgHEtEvj+89FxAxvHBlXzUC86KJQUoWFQsA=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=boe4deqyVfnAfZ/IhimcqQq5cNV2jys2GkOAvpPEQXHSl1Sb3wvqXB1g9G09epjQx
	 SyXR2My214iKp07TxwKl/8kigL+A4axHkTf6Bh+l5NZXR3I3mQuTTv0ix2JNMpaBrL
	 11x7HJpLnfIENZRCEu2UA9jiPL9TBvawyPZj+oQ9/+tyUMuY+TLXP2koAHmz6xtkZt
	 9FpueI1wcJ4ny2E3hbcNcWlVDi3AFriLKmri994hvKKLqs2DFlnAKb+et5BLejG3NW
	 oAG9A/SCrNYeT+uJbN7FIwagTgavvzzQTHMuTe3lHJdQOyyjZD4+SdiAan+65qruAR
	 JWUngvlScQsfA==
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 21 Feb 2026 18:53:05 +0100
Message-Id: <DGKTYBF8G6KI.3Q96DGYKYHAFO@kernel.org>
To: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [RFC PATCH v3 1/5] rtc: add device selector for rtc_class_ops
 callbacks
Cc: "Alvin Sun" <alvin.sun@linux.dev>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <linux-rtc@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>
References: <20260116162203.296844-1-sunke@kylinos.cn>
 <20260116162203.296844-2-sunke@kylinos.cn>
 <DFSN0O9RRVD6.1LCI38JKGO1R0@kernel.org>
 <77d373dc-c5f2-4dca-b0d2-b5cee6a21b3b@gmail.com>
 <20260220225341c5eeb835@mail.local>
 <d1c9e33b-e1f3-41c6-af5e-a85fe2b86d10@linux.dev>
 <20260221111619162a41a1@mail.local>
In-Reply-To: <20260221111619162a41a1@mail.local>

On Sat Feb 21, 2026 at 12:16 PM CET, Alexandre Belloni wrote:
> On 21/02/2026 17:31:09+0800, Alvin Sun wrote:
>> As in platform.rs [1] and i2c.rs [2], set_drvdata is always called by
>> the bus Adapter's probe_callback, not by the device driver.
>>=20
>> [1]:
>> https://elixir.bootlin.com/linux/v6.19-rc5/source/rust/kernel/platform.r=
s#L80
>> [2]:
>> https://elixir.bootlin.com/linux/v6.19-rc5/source/rust/kernel/i2c.rs#L16=
0
>>=20
>> In Rust the Adapter already sets drvdata on the bus device in probe. If
>> the driver also calls amba_set_drvdata() there, it overwrites that
>> pointer; on remove/shutdown the framework then gets wrong data and can
>> hit use-after-free or crashes. So only the framework must set drvdata
>> on the bus device.
>
> But this is wrong, how do you then handle the class device on
> suspend/resume or on .remove?

I think you misunderstand what Alvin is saying here. We do have bus device
private data in all drivers. It's just that drivers do not set it randomly
through dev_set_drvdata() et al. Please see [1] for details.

[1] https://lore.kernel.org/all/DGKPPQI0QE73.S8I1M5NCI2BV@kernel.org/
