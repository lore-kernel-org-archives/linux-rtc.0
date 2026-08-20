Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC2F488DAF;
	Thu, 20 Aug 2026 21:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787261380; cv=none; b=KAKU2E+P0piih4+l1VmmKHmc560/ZWPpH4zYPpKRXJCvEHyrsPAJKJxnnmdCW5sws+1tIVhOVRlWszmnIS4uAGVgyQK7uw4867ZtcsEFwP+B+0DMrWevsRNmZCKmf/qCUkaYtpoFZG96JdZUGb7sYcYlmQ5TxaY3qeGMexc3vro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787261380; c=relaxed/simple;
	bh=0CN/sBpECOBz7C7hwPJukR3qoriTAFuzWc+IerNTqMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xi9ZqUOrGFALewlDVTNqQ+mHL/t9jAq/QdvXEGa5xhQ+aAxUvrGcWvRgvoUuRK7vreUfcLyxB5zW5rWp4YWnvtsGXEs7B+3kCAnYvls4o+ZcGpODauJZmN+TBsJnZGNygSlWKo4KeVLQRtLLEmdjPX51XzMu+4ZUGmR3Za4jnS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eG95n/lb; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eG95n/lb"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 541E11A177D;
	Thu, 20 Aug 2026 21:29:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 228B55FF59;
	Thu, 20 Aug 2026 21:29:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E94A711C7688D;
	Thu, 20 Aug 2026 23:29:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787261372; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=IYysiw9xuZReqPetbCvsb6o0NjZeUpSaa/zjPN08UYU=;
	b=eG95n/lbODZjOp1jV9zrZY8MO1tRXS3ZCtVR8ionWSROxdhKcxQZ3k3q/YyyOEnz62KrSg
	8oR/EWCj0K3OSKBvHU90JgL8Y982JtqICsPTzzjPPF15OUKst3F6aLzHTQPcDbuHLAsOXE
	sgMTZoZTD2M8tOdlUykRE7mFIoAU5EIG8gLO42LW+Msv9AMSm46gMzUtFL9aJRhB3XGbS6
	bAbX/L0p+xwwhrtB0quGXSwspkyUOb7SG6K/ZwIXisgE13n63TtgJDmGcNxl3VSFhHv+wP
	cwhoxVlNJD5HnWaGc/2eky/8xhYBc/ZD4NCSpUU6IrWs0QaOQTn7ZPt7wjr+mA==
Date: Thu, 20 Aug 2026 23:29:31 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Teja Sai Charan B <tejaasaye@gmail.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: rtc: Convert rtc-cmos binding to YAML
Message-ID: <178726066526.423710.7810151663214770093.b4-ty@b4>
References: <20260709221944.159244-1-tejaasaye@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709221944.159244-1-tejaasaye@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Fri, 10 Jul 2026 03:49:44 +0530, Teja Sai Charan B wrote:
> Convert the rtc-cmos devicetree bindings to dt schema.
> 
> The original text binding documents only the motorola,mc146818
> compatible. Existing in-tree Devicetree sources also use the
> intel,ce4100-rtc compatible together with the motorola,mc146818
> fallback, but this was not documented. Document the Intel variant in the
> schema so that these existing configurations are accepted during schema
> validation.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: rtc: Convert rtc-cmos binding to YAML
      https://git.kernel.org/abelloni/c/745ca1b959d9

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
