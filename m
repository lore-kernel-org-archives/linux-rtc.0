Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.133.224.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793758388;
	b=WolNJjpBcUrI0yourpum0qFFcqF0FPApkGIQsk3htlZ1OrB2wBFF7biI49UtIkEK+1MH
	 tTg6irt/dS7PtPnrD/JNzX4R1HY+agY1S1HsKWOn19ifSK9gBIQtYVV/xi5BDhL2cJHk0
	 F/SciKAm7Ndx6Nj33Y3vaEc40zhbqXTBr1ddOoFFznNoX4vB/cjCLgrHazFhUoFJ5kPkf
	 T5rzN0bLz78TmCQkYCA85y6IugEs/o4AUPYsDmXS9OnYHM3CNqAO8UYbL1d7yX0E90Slq
	 6650K8YSG/YHXzl4+/MXRFc9iPEI7WC0uttP7H7g8uUFVaJFQZfK0yXEu8UBrafPGpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793758388;
	h=DMARC-Filter:Received:Received:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:User-Agent:MIME-Version:Content-Type;
	bh=7udu1ytKGKK0p5KHbtLgE14Fb4wSySMnCYPqFkPlqeI=;
	b=rKY/cKQNR8/XQuMwyL4cibaef/J0EbZtd0RqEZu/aLpfJa1AkhV01wSkfbeX61hhoX+I
	 majwWIGZUaJhN+bCeTVh0zRjRRr3NDGbjjvzKD2QGWB6I2z8Uv37tCFA8bY9mB222vE8v
	 3LxeyWg79cks/fWzd0r8Rz/BuTLwf/o7GkzXP4jd6ZTfWG2z9nsPinHIHhm+siiWeLSzx
	 hHSS/6ykmDY/fHHA3apCjFNKZqYa7glTEu1ClPc4kufbYMiZWFLBZtXJjOgS5rkF1gKB/
	 TySsF3oMOJ+FqnGMN8VpEPhYBFkUc9UpuBsAPk4UG1Ajslo1nBHAh7G1XaqqTqnbSlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=orcam.me.uk;
	spf=none smtp.mailfrom=orcam.me.uk;
	arc=none smtp.remote-ip=78.133.224.34
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F318D606A326;
	Wed,  4 Nov 2026 02:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F318D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 8936F92009E; Wed,  4 Nov 2026 03:13:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 8344E92009C;
	Wed,  4 Nov 2026 02:13:04 +0000 (GMT)
Date: Wed, 4 Nov 2026 02:13:04 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Florian Fainelli <f.fainelli@gmail.com>
cc: linux-kernel@vger.kernel.org, 
    Alexandre Belloni <alexandre.belloni@bootlin.com>, 
    "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" <linux-rtc@vger.kernel.org>
Subject: Re: [PATCH RFC] rtc: m41t80: Support SMBus adapters without I2C
 block transfers
In-Reply-To: <20261103225027.1248035-1-f.fainelli@gmail.com>
Message-ID: <alpine.DEB.2.21.2611040202550.15685@angie.orcam.me.uk>
References: <20261103225027.1248035-1-f.fainelli@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 3 Nov 2026, Florian Fainelli wrote:

> Maciej W. Rozycki proposed SMBus-only support for this RTC family in
> 2008. The same SiByte limitation was discussed again in 2018, including
> register latching, seconds rechecks and a possible regmap conversion.
> This change revisits that approach using the current I2C helpers.

 Thank you for following up on this.  I've always meant to get back to 
this stuff sometime, but given so many other outstanding matters to deal 
with I am really glad to get a helpful hand.

 Later I'll have a deeper look at and do some further verification of your 
proposal, however meanwhile here are corresponding lore.kernel.org links 
for the messages referred:

> Link: https://lkml.rescloud.iu.edu/hypermail/linux/kernel/0805.1/1778.html

Link: https://lore.kernel.org/r/Pine.LNX.4.55.0805130254420.535@cliff.in.clinika.pl/

> Link: https://lkml.rescloud.iu.edu/1811.1/07408.html

Link: https://lore.kernel.org/r/alpine.LFD.2.21.1811141234140.21654@eddie.linux-mips.org/

-- which I believe are preferable, since under our supervision.

  Maciej
