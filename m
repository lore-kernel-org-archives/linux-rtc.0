Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792503814;
	b=qw7KJVJio7yM6nezkH3lsulkp9mi7hhgwCtrENN+JIos3npaPu9tJBQFJCAL8buVJFRL
	 zMGalmBAZ56g9Ojt0F74yYFvrlj34ybbjDY5M+sKcqKncTE5pUDLINQt/f4Lv3TQk5rz8
	 QDCLKBM0D0+aJ6GIuk6WpZeZi4IGn24fNLK34RsfQyT+PokpxwO548FbU1eoL/O08oLDN
	 Sj4Bflv8mvu7zlHA+JGrsU7VUhGjzPgHmv6AgiqEMQvC0JSVXEJTZBCw7WUKk895FovsB
	 y8YIf7wTC+u9N2yYYpu7cO0gXzNVh0w7BOpsgl0CrSlKFrFKv7X8Mtk8jBhs3NYwdqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503814;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Last-TLS-Session-Version;
	bh=a7evs3c83W1K0F5zxXLeZ2sMhNgoUa3W9M3ODO/7lLQ=;
	b=wEjLMMO+d2al5/Za2j0Mcy4Px7AWWsGQIvMNN6v6kqxFI6aDnRKI0bIXVf78R3iCYc3p
	 vwoqMtkT50YKsuuV9MSTAlgNY/e56/pjdtt264lQJFj7Lmya6Zgo0j1nShPhttplXA/mM
	 xtsQibA0Hi5KJzSUjXq1BmHhKyeoVf8hXcQ6Lt2yE9N7355s9i/i5nYBNrjasOMzLXlUP
	 75piPBh4cHxE9qhJZaqNAfeFCHzjxj8nf0+/nlijh5gap1V/GB19BfagLumybREghMLjS
	 W/59bziHKkuIHZc4avBOH6UJ1RWG8wuW9x+geCIIKnzLZ6jBr9lskBgwl0jY3Jhvswg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=eiyfybd+;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A391960A260B
	for <linux-rtc@vger.kernel.org>; Tue, 20 Oct 2026 13:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A391960A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=eiyfybd+
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 303601A11F7;
	Tue, 20 Oct 2026 13:43:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EFC6860393;
	Tue, 20 Oct 2026 13:43:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 76C6210328DD2;
	Tue, 20 Oct 2026 15:43:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792503807; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=a7evs3c83W1K0F5zxXLeZ2sMhNgoUa3W9M3ODO/7lLQ=;
	b=eiyfybd+X2pk32UqSIsmjeuQkMNAyn1C43i1jHY9+4kFLJdeoDlggreSvd+5vcMkXl39iW
	iLLNJex4YdZGn17yHAlSqd5o3I4wOR/IMu1nGk/tq4tOTx3XybVBz1U5ujwFH6MSKRD9sF
	NqJP8pVV6pMBdGmx2MPd+vskXq/Nj/cuC6dUbtpkliYL1FVHw34t3DaiZZ+yLkgC4W6fGI
	9+kgdZ64ns+/vKP/GFVmjCrT3WZ9P/cnLIgBLwwacQtxgQg/a0mXyTJx3j45ZejpnP+fUf
	tYdSpSIOKpNLLMsPfMcSiTM5twNqauwBorU1eLPJpDCZWvYDc+8dfHXvJZPgOg==
Date: Tue, 20 Oct 2026 15:43:21 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Eric Liu <liuer@nvidia.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Guenter Roeck <linux@roeck-us.net>, Mia Lin <mimi05633@gmail.com>,
	Medad CChien <ctcchien@nuvoton.com>, linux-rtc@vger.kernel.org,
	linux-hwmon@vger.kernel.org, openbmc@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: nct3018y: report chassis intrusion through hwmon
Message-ID: <179250379387.320906.7689435596822345237.b4-ty@b4>
References: <20261001054108.3346426-1-liuer@nvidia.com>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001054108.3346426-1-liuer@nvidia.com>
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 01 Oct 2026 14:41:08 +0900, Eric Liu wrote:
> Add an hwmon intrusion alarm for the chip's chassis intrusion latch.
> Reading it says whether the chassis has been opened since the latch was
> last cleared; writing 0 clears it and re-arms.

Applied, thanks!

[1/1] rtc: nct3018y: report chassis intrusion through hwmon
      https://git.kernel.org/abelloni/c/c1c260266abf

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
