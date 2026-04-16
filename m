Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6070737C11C;
	Thu, 16 Apr 2026 10:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776333841; cv=none; b=qG4NtR1QPh+DxlO9mpsT79sSAt06K3rzEeVTY/K0jbe8pEBuFzvKj6DXKT958vNCx2WQiS5+X5EBvLtu6IHgzTRXTDlqpAJP9+JnLio8bD262t2V1eHYKOZxvFdLPKxKQOj0SGCzyGLkKq7nagL646cTqGQqlYE/Dqnpcvcjiz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776333841; c=relaxed/simple;
	bh=eJznwiWu3GS+G9YuTGcBBBnq7Dob2hnAe6bFBd1fFWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGZZUZiUIpS24qjOHgnH3q7Rh9zfEt+m8TpLsZzbCe4bBkFni0E7lWEN1CHvvMPIwq7SpzAsy71XVFaVyBRXkAvoiY18WSTtf0nkUskqOI1GP58x16Rq/Ne/BUEF5Kp1XTETHNRp1DYNoREwOK6LEoYZjkWG474Licod8HozmX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qyK79Tbv; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qyK79Tbv"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CCF2B4E42A1A;
	Thu, 16 Apr 2026 10:03:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A286260495;
	Thu, 16 Apr 2026 10:03:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 215111045A177;
	Thu, 16 Apr 2026 12:03:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776333836; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=jz6qYFKNci22zxAWa0vLjki+Xbsl10MmWaT9hS9sWNc=;
	b=qyK79Tbv0He5cPPGsSwcn+lVCvXGjTmv3N4N7u/qDZhmFp+hbI8pLmW9mcWyLOd2VyN+14
	xaoZrDsp/5wI4SSW45AJnwFEWEQOVHHRb0CE3upt71IMae6Pc0F7VTF2Iar2k3B9wmNk/1
	M3tIqi0ZASnSivJh5CEzgxo4Ft5/fHpTAT3m+mCW4Miqm29cFvvFaDIlwWjOeIygWhtMSn
	okX4uO2v2SidwDQyrLSFNUlJLru3RTjyLVjh/nYirnb9UIKwr02CvoU/KDpE27Zb5QShtF
	tNaWz7Fk9leY572KbswxsrSXuyN0peDtinPIJd7OOcSh5Uk9fvGrwL9Y/pH/EA==
Date: Thu, 16 Apr 2026 12:03:54 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Adriana Stancu <adriana@arista.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: rtc: ti,bq32k: Add delay on rtc reads
Message-ID: <20260416100354ac85cb48@mail.local>
References: <20260416092414.3210383-1-adriana@arista.com>
 <20260416095706.3212158-1-adriana@arista.com>
 <20260416095706.3212158-2-adriana@arista.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416095706.3212158-2-adriana@arista.com>
X-Last-TLS-Session-Version: TLSv1.3

On 16/04/2026 02:57:05-0700, Adriana Stancu wrote:
> Add a configurable "ti,read-settle-us" property to resolve a limitation
> where aggressive I2C polling prevents the BQ32000's internal register to
> update. This ensures the hardware has sufficient idle time to update its
> buffer, preventing stale data reads on systems where the "interrupts" are
> not configured.
> 

Why does it need to be configured?


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
