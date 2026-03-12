Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F35370D63;
	Thu, 12 Mar 2026 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773326054; cv=none; b=nm8n2rMlA9+un3PM4eMER7qIxj2fNSufaKn509/07NbzHwZjBq0vBAqDIfvSPruuUAw7fJyAB6ln6k09l7VSWC3xN/nKcU6yXaiKeHEtALWsR8xrK6osKzWqFJ/v0yca3TTBuF9Etc6t8FW0YMPIlpqfxqY8t7/olF7VAP2x1Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773326054; c=relaxed/simple;
	bh=DOXA6QtsfzkZPROElG3yAh0IASFe2LRsfsSO4JQZbbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmsHR79g/5RpkUlve7gYUFhylyMuQ/vNSA2wFWkjuJnnFqtud3mTK8+n/KnxbTzHYze4nPT9gkx+XcqvjkJcpK49UOF9geQ5mIZ06dkXsgNO3Z5Y+K0Ky9pO8mo9TlfldSUXeeiTzh5xRmGESgT3PFtt+oNoJWsW5rdjYvpPQ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=X/wF4OuN; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="X/wF4OuN"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B3F48C415B4;
	Thu, 12 Mar 2026 14:34:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F10485FDEB;
	Thu, 12 Mar 2026 14:34:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1D4E510369D8B;
	Thu, 12 Mar 2026 15:34:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773326049; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=IBs7k57OeLZl/WMHraT3wf8w2tDAH3Uvkw+ViJVliHE=;
	b=X/wF4OuNChjYf6mq9RusOsq+XlL7gpw5GZCEQCwbd6pRxOuxqqVIts4CnqBhy/aWl8uMDb
	dlUGmPIXCP/4k0r8QJ+vCO/Cshsgau8fY9M9kktiaDCPtO5ndFe+uoisB5xDpJZ7Kr/cRK
	KkIzOmqp+VKMPWRt8bMx6QK5Yl0mMrpuJjMq3aWebtUX1e/jgk7KqJAnS2MaI3xK5j7ndn
	G6a5YFC9HGul9Kni9og7/uPJ7U40H4tuZxW+67qE8vzxXIwuHC5fn2WAWoCxn5jQftt0rX
	LNE8IwGd3qSmWIEDolv5JDf3edvfXpVVZIhZmd6h4shFDOnA1Nq9Rjok+kEQAw==
Date: Thu, 12 Mar 2026 15:34:07 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org, Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: rtc: mpfs-rtc: permit resets
Message-ID: <177332604245.2624597.12073186352013045323.b4-ty@bootlin.com>
References: <20260303-flounder-slate-dd69766990ce@spud>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303-flounder-slate-dd69766990ce@spud>
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 03 Mar 2026 16:36:33 +0000, Conor Dooley wrote:
> The RTC on mpfs and pic64gx has a reset pin, but until now this has been
> undocumented because platform firmware takes the RTC out of reset on
> first-party boards (or those using modified versions of the vendor
> firmware), but not all boards may take this approach. Permit providing a
> reset in devicetree for Linux, or other devicetree-consuming software,
> to use.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: rtc: mpfs-rtc: permit resets
      https://git.kernel.org/abelloni/c/cbf39bfd4bf9

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
