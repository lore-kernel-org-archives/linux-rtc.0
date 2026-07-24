Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE9E175A7D;
	Fri, 24 Jul 2026 09:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784886616; cv=none; b=afeDxypLVfM07rkX4cJlxX402WrOQUqlCZGjfJsDdnWUCCXHqtjK0XJYvWzNYQOaxGvr/u8ES42e3MRk0g7xH9JTfZmGAhZH56TdS9hQ3l56AS0JOYXvsC1l9z6vorhD48k0CGmalC4GDf8buvWjJO1JqFQXhUfAuHTO1T/2aEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784886616; c=relaxed/simple;
	bh=RnjBErVs/DyjkPpyINuzOLidXJiE296aEazL0GPAVM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XceMkr8SRroYBhrOY2eyt9nCjup+IcfFFSSTSVDSQlzOfrBYDeU4xsw+Y6xPQZQZsNqqD/bFK6F2PHVsjNGQAdAapZkICUXdX/p3COAysTQlXlLBZ3NX+HfqEHHag14TLLGfKhxpcozy4YYmkFuXQdcirZc8QjnVUa1vwA6d854=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+CeQbq3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+CeQbq3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91151F000E9;
	Fri, 24 Jul 2026 09:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784886615;
	bh=RnjBErVs/DyjkPpyINuzOLidXJiE296aEazL0GPAVM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j+CeQbq3exzJY7j0+48KZQIS2781qkc2TMzD0FJLgKxGNe3tOsp/njq0FfG9gJXI6
	 DvRv7ZzAghBx9e/QD9bnaM7dQhThzZmxrHYMCcbKofRwRWmlNZ5wkbPQYMhrM8gsAx
	 yhzArx9wKMUh13hHoGyh4DNL3MNcc9lWFeR4iU+nHZeSBqhACVz8tuPctbX3wcK09r
	 1+QA1RAVC9Vrk27ALIaja7GtKWO8iS21tknG6y6Tzz161fChfOdlW/5m0EGFQVxmIz
	 K9E4TMTXQU4mms75B6e/zXzRos1yGLyzdbHuSom8FlAOn3rxOPvddywXQQq2E954ss
	 b5LN8x4ptt0vA==
Date: Fri, 24 Jul 2026 11:50:11 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: alexandre.belloni@bootlin.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: rtc: abx80x: document ABX81X RTCs
Message-ID: <20260724-mystic-yak-of-painting-1efffe@quoll>
References: <20260722195814.298552-1-apokusinski01@gmail.com>
 <20260722195814.298552-2-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260722195814.298552-2-apokusinski01@gmail.com>

On Wed, Jul 22, 2026 at 09:58:09PM +0200, Antoni Pokusinski wrote:
> Abracon AB0815 and AB1815 are RTC modules with SPI interface.

Binding does not allow SPI interface, you need spi-peripheral-props.

Best regards,
Krzysztof

