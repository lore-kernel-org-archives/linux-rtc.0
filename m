Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5B914A614;
	Sun, 12 Jan 2025 23:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736725308; cv=none; b=InbWVduZgLmMwx9MZVtW3cjjLDVTHWdAGX1pJJUOPbJU5h89nkCsgpohZ1ZvrUv4BQiUnQoSK6fFjf65DUNImmfvZYUtPfzZVJKNFS4tE7SLjiVHesjbONpeS1eQUOlLVyf9TSqYQAQ68C7IbxHFdRFSu58mM1/Jh3cD0SsLaTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736725308; c=relaxed/simple;
	bh=4nPF6sXE1uMEXXSi0JtSfGUVB3L0FZt1B573qediNdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZAyM5Ljkia4tUWZKGGv9HEBzaJiklWOO8tioelvYF0aMybylc0QjzK8eA0kQlMkP+JhQqfk6fJOwHUbCNfKcc1UxrpR0NfTpOm3P+NWXGALaKwJqT1sgdiJpat7Z8IBSejLbNO2bBIEMEmd6pQehUmXKa9yJ83SokVCl8Uq12Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=peOjpli9; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="peOjpli9"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7486C1C0003;
	Sun, 12 Jan 2025 23:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736725304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Zd4Crf5dozzhc+r4YH7BcgHQz1O7Obz/jZqJO/AifQ=;
	b=peOjpli9G/AqxbBzILroJY95A/J4iAi/yDF149WGIyA8zhrwj6H+sodxaX52lvW/o/qRKo
	4/HXWCUbQvsXjV74zlbKG8NQfmv14GQicNxjlmUY0/ixw85OZwnC/FpY7hrNouiR0983JS
	mW09+cEnD+TB9zw4d/qzF19UCxzmqSu8zESDeLCunmobQPPiuQF6uMb7YOb4oYP5QgYptk
	21adyFbBijM/9T2lBzgHjZjbQtPjAg+z+IlKd5EZ2Wsd9AS9edU8YrCxX9LGaYz48e5Uek
	fSaERKqHmR292kzgn27rfYcE71mSfTTWYL2rkGrLIXhO3HytIFJiTmPESBiT2Q==
Date: Mon, 13 Jan 2025 00:41:43 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
	Michal Simek <michal.simek@amd.com>
Cc: stable@kernel.org, Srinivas Neeli <srinivas.neeli@xilinx.com>,
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"open list:REAL TIME CLOCK (RTC) SUBSYSTEM" <linux-rtc@vger.kernel.org>
Subject: Re: [PATCH] rtc: zynqmp: Fix optional clock name property
Message-ID: <173672529557.1488825.1587396647301990386.b4-ty@bootlin.com>
References: <cd5f0c9d01ec1f5a240e37a7e0d85b8dacb3a869.1732723280.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd5f0c9d01ec1f5a240e37a7e0d85b8dacb3a869.1732723280.git.michal.simek@amd.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Wed, 27 Nov 2024 17:01:22 +0100, Michal Simek wrote:
> Clock description in DT binding introduced by commit f69060c14431
> ("dt-bindings: rtc: zynqmp: Add clock information") is talking about "rtc"
> clock name but driver is checking "rtc_clk" name instead.
> Because clock is optional property likely in was never handled properly by
> the driver.
> 
> 
> [...]

Applied, thanks!

[1/1] rtc: zynqmp: Fix optional clock name property
      https://git.kernel.org/abelloni/c/2a388ff22d2c

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
