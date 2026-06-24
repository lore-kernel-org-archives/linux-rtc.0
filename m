Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9F33E5A34
	for <linux-rtc@vger.kernel.org>; Wed, 24 Jun 2026 21:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782335738; cv=none; b=PEkttZsOTeeTWVhSytw3pzDWSG7VYxfwgFuIX2H8+JbTSpyPk9THY0oG5LB1XSgH1dbaZJNPevdl4KQccLdxxqrf6PnzyHbVLXSE99K1Ous8H86erUR43vOJfHPQyGRlbwoajI/O1g9s1COWtY9vRE6Tr3x6E0Ba9ZwixPr9wPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782335738; c=relaxed/simple;
	bh=8+Tz2wcICAvnONh9G2yDdK3WLJUQtA4ebKoIfNXDAHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXwgb74grr12pYVx2m0X79nZjbV7JG+45yog5rvfcG+dFOF4JlnI7kQpjxLF2cXM6lckdzrLgj1n/aUlg8pc3Snz7yQUg6FvbWF0WFfdLV9BxKH2qMiS6LWcwnktm+zdgNTz6eoPg5+X4HrJBXLxva+KC/JTXRw8oxN6HsC1lEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=yB8tYRn+; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="yB8tYRn+"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 06EE71A094C;
	Wed, 24 Jun 2026 21:15:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CF8D4601C5;
	Wed, 24 Jun 2026 21:15:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 49B76106C8468;
	Wed, 24 Jun 2026 23:15:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782335735; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=fZx+6xjHPRMW3K3siAMWojAagmcwhsm8cdaR644WEFE=;
	b=yB8tYRn+4MBt/aTA4Y/ErC+7TRlTBW0HGDOybRoJA/BD9JJmNO095Soktwnfo5rOsTsDWs
	WL48svqI8hTSbIQ4ZageUQedkTSdrTlIgsdYsi+Z3lJWuBRJobwveV6PhqtvDi81uggpxd
	otGT6yFuNbbQeeSLkQd39Qhb2YpU8MqgW8mOwG/jZpIbxhJghpUxZd/L0fk1t89d/Ii7nV
	iQDFqPs/ID6eJ0IovYYrwviAYKXW8Fv34IZ2WJhQHleAHIQ7Ovpg5GjLH4pMb3KI1k7hYA
	pWeTuwBqIVvYGYnvXqczejnHp4wXsase4yD48sShEZfSYsk7Oifvar/833XL3w==
Date: Wed, 24 Jun 2026 23:15:33 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	Udaya Kiran Challa <challauday369@gmail.com>
Cc: skhan@linuxfoundation.org, me@brighamcampbell.com,
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] dt-bindings: rtc: epson,rx6110: Convert to DT Schema
Message-ID: <178233558783.1517260.7052068183567523489.b4-ty@b4>
References: <20260514173851.25088-1-challauday369@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514173851.25088-1-challauday369@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 14 May 2026 23:03:32 +0530, Udaya Kiran Challa wrote:
> Convert the Epson RX6110 Real Time Clock devicetree binding
> from the legacy text format to DT schema.

Applied, thanks!

[1/1] dt-bindings: rtc: epson,rx6110: Convert to DT Schema
      https://git.kernel.org/abelloni/c/c7ab7504631d

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
