Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E05D63CB;
	Mon, 30 Mar 2026 07:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774856066; cv=none; b=jwaW/EilehE85yfJwOYfcI20Z2LSHjXdVlS9SFA6uQwHTApKsDUESdCqknlAd9vDQ95AYk6TFbT9VLlxr+022iajyr7wMApvAXnxWTHL+TKzHCG8yUIjgneCb4JuceyQGWjcLospCXfk8xm4egcRnaCv4Mv4HCzFiov4FKINu+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774856066; c=relaxed/simple;
	bh=ZnyPHU9jj+dpwp2gx/GtgfjROC+/EifViu+Ali9VP0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l52+rv/9MVivurGItF/EZINaWJApNDT+umacoyYxc3j9YoU/4fzJIZUcP1gyBoG+8YOWFYDbsMSV48UTPYel8J1kNH+7ovQuX1FxHpX5+0Vs4qFnAYE/Oysn6ajniyprCGHYPLpOzoM+sJzYq+B39SzgeOfNfoa/m5qemrPrJS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jrb7Oygw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jrb7Oygw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21EC5C4CEF7;
	Mon, 30 Mar 2026 07:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774856065;
	bh=ZnyPHU9jj+dpwp2gx/GtgfjROC+/EifViu+Ali9VP0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jrb7OygwR9S4zvo2CVY2liZagoqbIkEBf2xCb2o7uNzQyZwrOQfWbWrU8TsApGNp1
	 qlvlhxF7gjddmjGzZ7u9SA989kRWoCrIv3qc+bKJY6tqpdzbdZS/lTInNuGdBwMor9
	 YAobm1U/eZHGJU0mwJfaPYAMTryfReK/Hmhz8SMcucVRDfrOV9NkcwUlgs4pvTaLK5
	 4tOsZ0ild4dmSE4evCYigSc0580ipKjOW0x0kCbwyRZJ9b4m/XQDxaTcx2IVbc+fHP
	 9Xra0NU3bMgkVX7jYLEDp1G/0gWyU7OfiATCCoklxprPtl9gNwUgaSPkXhJYfC9GQH
	 kKGwoiuuehLUg==
Date: Mon, 30 Mar 2026 09:34:23 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Serban-Pascu Robert <robyserbanpascu06@gmail.com>
Cc: alexandre.belloni@bootlin.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, daniel.baluta@nxp.com
Subject: Re: [PATCH] dt-bindings: rtc: moxa,moxart-rtc: convert to json-schema
Message-ID: <20260330-daring-tan-cormorant-58f0d2@quoll>
References: <20260329184615.454887-1-robyserbanpascu06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260329184615.454887-1-robyserbanpascu06@gmail.com>

On Sun, Mar 29, 2026 at 09:46:15PM +0300, Serban-Pascu Robert wrote:
> Convert the MOXA ART real-time clock text binding to DT schema.
> 
> Signed-off-by: Serban-Pascu Robert <robyserbanpascu06@gmail.com>
> ---
>  .../bindings/rtc/moxa,moxart-rtc.txt          | 17 --------
>  .../bindings/rtc/moxa,moxart-rtc.yaml         | 43 +++++++++++++++++++

Is this another part of GSoC or independent try to hop-on the same bus?

I am asking because in both cases I expect you to follow GSoC
guidelines.

And this was not tested - you have clear warnings in dtbs for deprecated
properties.

This is not a trivial binding and you were supposed to do a detailed
check in git history and in all existing sources.

Best regards,
Krzysztof

