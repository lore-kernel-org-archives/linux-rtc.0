Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102FC277CA5;
	Sun, 23 Aug 2026 19:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787514642; cv=none; b=kci7i7KpUfjGWG5BrWrFuzvbDivmTazGHmlK4LrirPN+aO3GrR3QpYlgg01D7CoIv7pIuOUWmNqJ5H3c9HHGK38Ej4LZeIcHfxXUcTTaWs7mX1Gj3DRm4j/7NRdmAjQVakST0WkcCN67d6dAxJyOL/QPNVUHSI7DWF/eF+MH5s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787514642; c=relaxed/simple;
	bh=5w7/RMbc/STrPAtBYUdnaxXihsHr+6L1l3qYPU5FER0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=myve11DaXCLpMERp4dhDbKI91HpbF+KbagcFpLhC0qnLklrNz77QDiSkUzW4fY+LYj+r+u7g+SFdUKmbwvXx6zMrhRa+TEEf3OD/rz9oCRg471OVztyQIjBNU8paTurPK5cdr2yTZiQsSAeuvcOBN7tE8JVIP5ruQ0CwdS6rOwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zT0+RV6X; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zT0+RV6X"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E96704E41372;
	Sun, 23 Aug 2026 19:50:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9767C60378;
	Sun, 23 Aug 2026 19:50:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2A0C311C78576;
	Sun, 23 Aug 2026 21:50:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787514629; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=FI8iZwkb9AvvBWAVl1SifeWOG9uPTOrrRE1ZW7PiES0=;
	b=zT0+RV6X0lDfRVw2+6MB1Vq6VeJNkBZiZJ4CTJrFwV6lYaB2LqE90RriDutE0RSnPUZDqH
	7FmKvvsO8/Gmv1cIcQYTNTWKPXhIQTlZYJpZGvoa+wiZBHh3tc5+5xIABv/Pka7HigYBBS
	BPl7XytZcj+lhP5sZddnYmRS8/BWwAYV4Ef01PEgjEBFI1yCBwDNlUg9xTEAAao8Qxx/DX
	vJz8WgtU1qnh/T4JSjAYnvaN25SowSFJVEIcqgBdaSIM1aIOcfvpUf7eYuOyUCaEt1tFWG
	3aGIFVhOls7QE8Ma4JZv8sqWC8jFpp/3yFZf11oXbxE02ZDAjHxRvt5Cky4u7Q==
Date: Sun, 23 Aug 2026 21:50:25 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-rtc@vger.kernel.org, openbmc@lists.ozlabs.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH 0/5] rtc: Make sure clk_init_data is fully initialized
Message-ID: <178751460908.816082.16865012450264727395.b4-ty@b4>
References: <cover.1787241693.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1787241693.git.geert+renesas@glider.be>
X-Last-TLS-Session-Version: TLSv1.3

On Fri, 21 Aug 2026 12:09:01 +0200, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
> 
> [...]

Applied, thanks!

[1/5] rtc: hym8563: Make sure clk_init_data is fully initialized
      https://git.kernel.org/abelloni/c/db005bdaa5ff
[2/5] rtc: m41t80: Make sure clk_init_data is fully initialized
      https://git.kernel.org/abelloni/c/bdcedfee8b87
[3/5] rtc: nct3018y: Make sure clk_init_data is fully initialized
      https://git.kernel.org/abelloni/c/096c7ef4ef66
[4/5] rtc: philips: Make sure clk_init_data is fully initialized
      https://git.kernel.org/abelloni/c/5ef3d51a3aaa
[5/5] rtc: microcrystal: Make sure clk_init_data is fully initialized
      https://git.kernel.org/abelloni/c/a12eac458814

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
