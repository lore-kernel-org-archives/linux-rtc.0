Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9A033B6D6;
	Sat, 10 Oct 2026 08:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791620150; cv=none; b=C5cJmfceTL1Tlzq5wmTwDwUiO1Dad8qXqOst9lWqi6w1CfbaTn+Ig2OfLo5TMlCgN6vsTTF1gpRWOf6k6yG424jC72Xi3I7KWpSKxJuBosZbtWJW3ZWIAcUXBoJ7YYqxqYMneg28E8FOQaMdG69QjsredFgnAAVSHsZhocq/8YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791620150; c=relaxed/simple;
	bh=6z97pdI1uZYujtJxUCppFRYohQOC9OEsjsLpWXnIJZE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XYrmFzp2+QsnWAvES9q9xV56taMRbBd/NzoyLDLQuKuNaqDfPFKD46gAbvUkEYBEwL/ebaZCmO4ffeWSakKUNAWNtzkH684xrWP1kv8G8g2fMR7WnXlgAdWIoNN+0AkAfHKiA2+X/ekgrcSQhAssXRKrhwmZ3b9UEeTINeUYva8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Q3emQKKw; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q3emQKKw"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D512D1A1156;
	Sat, 10 Oct 2026 08:15:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 53BE86075C;
	Sat, 10 Oct 2026 08:15:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E1FC411D70089;
	Sat, 10 Oct 2026 10:15:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791620142; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=6z97pdI1uZYujtJxUCppFRYohQOC9OEsjsLpWXnIJZE=;
	b=Q3emQKKwcA8HrP+PSKXRAFrHRPlNRXjJzxwk3SpylaY3K+C1rx6GLzvyrRNMGTP/8/q40t
	eZwX3zVjtpWQy/YMl8lB+vLB2ntFZjYMGyhxIwLDcI749VNwBDGmLLtlmXt4ub727KsOL+
	wlHqz5vM+QvMifq0eaIzQCAVn5nPv+ELKIDmFnJQ0YPwx2xWqbaSgifkJI01Gh2uhyimeL
	jrH0a6xkZBISo8Bvvdw9Kq6KvL+ctFxyB5HlmSZT5kz7gIAnkEcZwBDWMxCuFXvRnbyTRF
	qLJDC7VlqFy/dk4xD6sTHi5OCZeKaTgiLbsWfGkqaIXK0RCpsDieg+tLoTUv0Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org,  Geert Uytterhoeven
 <geert+renesas@glider.be>,  Alexandre Belloni
 <alexandre.belloni@bootlin.com>,  Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>,  Magnus Damm <magnus.damm@gmail.com>,
  linux-rtc@vger.kernel.org,  devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: rtc: rzn1: add resets property
In-Reply-To: <20261008201953.34307-2-wsa+renesas@sang-engineering.com>
	(Wolfram Sang's message of "Thu, 8 Oct 2026 22:16:53 +0200")
References: <20261008201953.34307-2-wsa+renesas@sang-engineering.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sat, 10 Oct 2026 10:15:36 +0200
Message-ID: <875wzagedz.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

On 08/10/2026 at 22:16:53 +02, Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:

> The RTC on R-Car X5H does have a reset unlike the other versions.
>
> Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
