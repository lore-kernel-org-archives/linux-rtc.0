Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C7932ED5C;
	Thu, 28 May 2026 07:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779954193; cv=none; b=lGYAni6HsyIHMU5XagRG/HAPDvcpqksSiGAFMBdwrfJ2Z8w/XCN85AQdRX3g0pB61t+WeGAz0W/dU3fwZGLi9ayhzNZSaQGPO/eeSSlwvdKMKs7VvyDY1C92TGolI9j1tW5jedX/YXiofqBMtpy+RkRIJa16Lb5sSKz4tIHPqBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779954193; c=relaxed/simple;
	bh=HUZncAlvgO/+2KCZFfdlxhTUWrnC5IuWSmJOnJKCiFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9oW3OW9q5oyS28jeBDnUCB7FzlHt2IIP1lpMNW/PC1PM+MTWBI45IhoiGhWqaGmUH6krhFoNw0e8GDPlpYBHatzHc+F1sIVxHTD8n2kQXYYEFQAmgvoUAQ9n4EBofyo42RNjub2ecmu9qDS8n0Cqf8WRB/oWvSUVL2gceZaMBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oorq8zeF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oorq8zeF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339451F000E9;
	Thu, 28 May 2026 07:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779954192;
	bh=nM/ONQY0Pc3YNOQ/tfQQmV0JQlhr+oJ4X0dD7oLajvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oorq8zeFlJh5pS3i4o8KSnZu3DhtRGdvbMoutYtphbHEDEaYP980+6MtGCAu/o5yD
	 TvRw3gtprOpzS8PPYpik0il+qBzrbufpAOLSUmV5G89UdZoOq0bawr7MIT0iR2KgDr
	 dymahtxgBl4QjagU6j4ZzFvYCqjVqigze4hXuyQo0SHSWg6qU5MDMksRaqLn7X6++o
	 6MpxJjfxGIzTPkBskRhPrVSSBOfwnpfZx4boqTRCA4JcUFVAhCUODODIQTlAXwiEHe
	 etZvB9VXR2xlgDEExcOzpnYQVMss/rwy6E0AeRZ5vEwT6sFcr4t5k4hs4AGBuyTO+P
	 8suqD7r1hMhdg==
Date: Thu, 28 May 2026 07:43:09 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, linux-rtc@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] rtc: Drop unused assignment of platform_device_id
 driver data
Message-ID: <ahfyDdaiCPiacQqW@google.com>
References: <cover.1779950275.git.u.kleine-koenig@baylibre.com>
 <9ec7a174605a17dd19c011ee2253de28d09b02bd.1779950275.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ec7a174605a17dd19c011ee2253de28d09b02bd.1779950275.git.u.kleine-koenig@baylibre.com>

On Thu, May 28, 2026 at 08:48:10AM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> The two drivers explicitly set the .driver_data member of struct
> platform_device_id to zero without relying on that value. Drop this
> unused assignments.
> 
> While touching these array unify spacing, usage of commas and use named
> initializers for .name.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
