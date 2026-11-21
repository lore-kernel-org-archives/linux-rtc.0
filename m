Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795260199;
	b=s1ZwfTNNyPpMBRDtqYXYJ7T944uyxbjFD8JXX8UhmEFQQqXKmdz3dsH/P2KFnYTC5gB+
	 YEz6jY4pUOr2eZYjluFy7EjNLmKt6SA/nX0b8pDDA1GDdCM11WHZMlGigQ5CWRb+b1beX
	 up9oCuSocUaBieoI0g/r9hWIe5/XiXrdDajepQyI4qMUCIJZEXIFS+n7X/mkjtuprZU35
	 sx3S7uUPl2NqWVg3wPsNrP9UDXxL38ZEZZ+tLSAgr+LANiIXnv8qr9IsVGWKa31cNw29k
	 1N2Gs9qiTNAvZdHZG1Z0EP0eTjHaNxBgVZQXvOS6G9YZ7iCniLn7ZKWRx4M4SnxLY1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795260199;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xm3swyOD9hZAartdvtVYhOV619I4AuZu0vugsVSqOuU=;
	b=pq0B6E1/fibc3qOZErA3EgbNmci1PQm8FU/hvMJNMaMkpLaU1LNpymwWH0T25oOGpjkH
	 pXcCS3V/F13qqtVjKVLXZDUtdccdq9dyUWcKfZEHYIVtRGxIHf9ClxJiKOhElML9CIS7Z
	 +01ZPSdw6LcyS9b1zoDEzm+8I/u2VPzPZvISeYJQrVP5eL22sp6re8aIznTnSbA7k6D5Y
	 V7v+m/+z61fTT4O2P0xKdzOjXIRdTF0XWmwI3hEzeO07iSPuf3Z4//BlaRn/G6/wnMIAT
	 ECcqLw9zqvwidcO2gzEhAZsbT5a/eetAuakcryriPSViIPaRkblW6haAK3Avd/3bYoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gGH8UoMm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24413606A320;
	Sat, 21 Nov 2026 11:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gGH8UoMm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64D91F000C0;
	Sat, 21 Nov 2026 11:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795260198;
	bh=xm3swyOD9hZAartdvtVYhOV619I4AuZu0vugsVSqOuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gGH8UoMmuBvFymZmxiVdxqpxIy01DlJgFtg+AmYxWqcG+XFCU7fzm9hDGLAARfQCh
	 jQne0iB6/6vXxBQr7h++NQr9wtkCwemedT8uqMwfJgSOETXs4/4gXzT1nJVmYSsHjW
	 R7jTmncQG0cfV98sgUl5dHylYI4ZajBN/j3HC0gkYF0EIAkcTp5ZZ9qw7YAr4tkHdT
	 kQKivVQJQHo+D3jCHFOcSKPuE4Y7CxWHkNQDLEVAwhfdWVZ25vI2rydqZJXGAVzN5Z
	 pKDgBw7IXrh/D5GsC4XWECuYf6VBVoGLAGc/wOC3IVdAc4GVWo7KA/LfAKdiB2g9K+
	 u/NXSuyZOSUaA==
Date: Sat, 21 Nov 2026 12:23:14 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: pjh456 <pengjunhao409@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: rtc: haoyu,hym8563: document vdd-supply
Message-ID: <20261121-attentive-grateful-caracal-5cefec@quoll>
References: <20261120113502.563894-1-pengjunhao409@gmail.com>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261120113502.563894-1-pengjunhao409@gmail.com>

On Fri, Nov 20, 2026 at 07:35:01PM +0800, pjh456 wrote:
> The HYM8563 is supplied through its VDD pin.  Add an optional
> vdd-supply property so a board can describe the regulator connected
> to it.
> 
> The property is optional because some boards connect VDD to an
> always-on rail.  Describing the supply also lets fw_devlink order the
> RTC probe after its regulator.
> 
> Signed-off-by: pjh456 <pengjunhao409@gmail.com>

What did the LLM tool ask you to do in regards of the commit msg?

What did I ask you to read - which document? What is there about DCO?

So at this point you are about to be treated as a bot.

Best regards,
Krzysztof

