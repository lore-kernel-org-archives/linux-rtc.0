Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC043E5EC5
	for <linux-rtc@vger.kernel.org>; Wed, 24 Jun 2026 21:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782335809; cv=none; b=bQ+n1Rrt9dzAhraJ3u6AIFhW0mv89YcSd9eUgLYAn2uTOta2HSPK7L8P9hfTGwzL8mS5bvjTQuHAcNtFfTbzr/Abhbp3Yo3UrPXIPCb8D6cyMmzerwVNTuzAujh6ESYJLiHwrcIOIsKwI4zlTWiwh4uunRpi+s6Mi0+d7QEI5Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782335809; c=relaxed/simple;
	bh=3UyBs04HfmneOkBn5MHla72aREGAHdv8PrXO423iVL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrlcPMN9OCxyW2ulHnrq5usfKcr96JGcrN8ggG7RWYIwLQ1YYWIwEl5ahaJCa4eDutYHAxYvJdISyXvjyCEyuzrGT97FgH7YMXZk852RJm3kRS2yC956QNJ1U74fnA4wkN1iWxngj+VyXAfoUz0PYux903pye/GU4byeXmGqpY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZFrS24Gq; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZFrS24Gq"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 218D1C6B3BA;
	Wed, 24 Jun 2026 21:16:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0645B601C5;
	Wed, 24 Jun 2026 21:16:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9F1C1106C8468;
	Wed, 24 Jun 2026 23:16:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782335806; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ArYnu/1YanuqdlV21/ZctLMYIsPxKet83mcYTyOtQec=;
	b=ZFrS24GqxJYKAJxoy9vCQOrpfZcgIPX4nupird0dtQGbPOfrq5K85w4+9dM3I4kgnQQU1b
	xS7j5cKtUf3hTEUhPzEr7DM/aI4xGHfGpXNeDwXbebuxiMRrf0ogFptnLEVS4xpRHKPQZG
	TL2AXUkzoktLkRQ6JDUljTvL/R0D/k9RcIDsVeMqaBiqEFepjCEgt+Z748zSGpdgwCc5fy
	Y9xkKiy6TAw7SYBClX/8310oKVePASQodwOA60f3c13Z1BQOiWfLD2osHNmH3NTgO1kCTb
	dhDeb73oZjjqnuPSKkXSOhoG7hR+W+urvycKhp30zAhb25LQyCH74LjYwcFsUA==
Date: Wed, 24 Jun 2026 23:16:42 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	linux-rtc@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org, Linus Walleij <linusw@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Karel Balej <balejk@matfyz.cz>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v1 0/3] rtc: Use named initializers for
 platform_device_id arrays
Message-ID: <178233558807.1517260.17147492956958938039.b4-ty@b4>
References: <cover.1779950275.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1779950275.git.u.kleine-koenig@baylibre.com>
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 28 May 2026 08:48:09 +0200, Uwe Kleine-König (The Capable Hub) wrote:
> this series targets to use named initializers for platform_device_id
> arrays. In general these are better readable for humans and more robust
> to changes in the respective struct definition.
> 
> This robustness is needed as I want to do
> 
> 	diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> 	--- a/include/linux/mod_devicetable.h
> 	+++ b/include/linux/mod_devicetable.h
> 	@@ -610,4 +610,7 @@ struct dmi_system_id {
> 	 struct platform_device_id {
> 		char name[PLATFORM_NAME_SIZE];
> 	-	kernel_ulong_t driver_data;
> 	+	union {
> 	+		kernel_ulong_t driver_data;
> 	+		const void *driver_data_ptr;
> 	+	};
> 	 };
> 
> [...]

Applied, thanks!

[1/3] rtc: Drop unused assignment of platform_device_id driver data
      https://git.kernel.org/abelloni/c/ba5dca876b54
[2/3] rtc: ab8500: Simplify driver_data handling
      https://git.kernel.org/abelloni/c/6e2f1f0184da
[3/3] rtc: Use named initializers for platform_device_id arrays
      https://git.kernel.org/abelloni/c/041ca8884410

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
