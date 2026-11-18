Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.133.224.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794967164;
	b=yleItUrTrL0spIMVTdbktnXOkgtE7Y7t9jj7igzFC2219R3j6ykhO06Do0/q6GSpxR/u
	 oA9jR257rkYLKnsQpVQ8VAKVFDGjSngCRBw50QKtw3AHgtSUdytgely3PbiFqs2Wy2gzf
	 4YvQHWD7ydp6h2RAtUrcxxZ0x56zk5wXHUjQ1QsyAmYI9hp8AUT//uatnMtYrz8zVIQ5V
	 YeuE+0hqACibD1pgdzq76t9bpD4nruN7GT2KgxunstWcW2x2Sg8mbfwOBVO4V0m+0yHEb
	 3WYpYNEWofkswD1/n9whPLaFnrHNd4/3WgDvKvg18rtgRLPaSlGXiTtkFnWsENks8nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794967164;
	h=DMARC-Filter:Received:Received:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:User-Agent:MIME-Version:Content-Type;
	bh=YXvyIN9D+f/OPmEpdLl4SRjTdUjd8ReYNTZq0CniktU=;
	b=EJRsCLDBhZC3Zl896M7Zzfnu/te0T5SVubkmQyJ3VfDSeP0SFi9ZI0eR9s2X0xittB/G
	 KkvBaFCbFeU5tEHldZ6TGy+aiUF8cA7Fxlpwvl3ZyGQYZ0HMfemBmfZQaeaKJiAMnMQvT
	 6NGIDIKDDp/uj1+PU1HJvqpCum+bxjHuXaxWROCFsJkFkHDtYlpD1dAf3fiiMuT9GX+tK
	 CEFuPs9i2jdAHRHaghk1KWqwLvAEAPY3X1NvW6KrhM+RB+mOxn4yo1JcYw+cNLjfHzduj
	 dPfgLah6DjQibY3fgZDbvHgaVMeOv+rd3yLPdFjUyFXChumm9UpTtNVngRYsS0acdqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=orcam.me.uk;
	spf=none smtp.mailfrom=orcam.me.uk;
	arc=none smtp.remote-ip=78.133.224.34
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2FD606A31C;
	Wed, 18 Nov 2026 01:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE2FD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id EE41392009D; Wed, 18 Nov 2026 02:59:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id E6D4892009B;
	Wed, 18 Nov 2026 01:59:22 +0000 (GMT)
Date: Wed, 18 Nov 2026 01:59:22 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Florian Fainelli <f.fainelli@gmail.com>
cc: linux-kernel@vger.kernel.org, 
    Alexandre Belloni <alexandre.belloni@bootlin.com>, 
    "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" <linux-rtc@vger.kernel.org>
Subject: Re: [PATCH RFC] rtc: m41t80: Support SMBus adapters without I2C
 block transfers
In-Reply-To: <ccee564e-c705-4669-aef8-e0ed284fb776@gmail.com>
Message-ID: <alpine.DEB.2.21.2611180158030.54328@angie.orcam.me.uk>
References: <20261103225027.1248035-1-f.fainelli@gmail.com> <ccee564e-c705-4669-aef8-e0ed284fb776@gmail.com>
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

On Tue, 17 Nov 2026, Florian Fainelli wrote:

> > Maciej W. Rozycki proposed SMBus-only support for this RTC family in
> > 2008. The same SiByte limitation was discussed again in 2018, including
> > register latching, seconds rechecks and a possible regmap conversion.
> > This change revisits that approach using the current I2C helpers.
> 
> Maciej, Alexandre, any feedback on this approach?

 Last week was the end of Stage 1 for GCC and sheer madness for me.  I'm 
still recovering from the backlog and will try to have a look soon.

  Maciej
