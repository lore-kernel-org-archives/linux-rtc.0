Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87213594A
	for <linux-rtc@vger.kernel.org>; Fri,  3 Apr 2026 16:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775232536; cv=none; b=LASdndFykwS+y+gf3Y+e7IbcQfmjIl/Efif/UOgBHuRJFW932trs4wEtmHLUwmxqfuzwWIzmygeSRD4AIs0FOwkLqnK7DymMv0cCCUX3x8V6DD+64kfqzYAve7UMsPT9nyBKn761qPxkNzeLsDr0QnwQ6gxH68mXrr0md6lkD8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775232536; c=relaxed/simple;
	bh=CpOrX4lVuPQTMEWoZmKcpJG6+BRDMgJv0JqQ/2qgrwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVu7rfqny9ygxeZLRJMT1mJEMAfM4b933zqtbd/hXNfh2J7NAJO+/PKnS4KjUhZ1fhAKub1FX2gWauXZ/izg9T6etkUgqqBX6RqFgmeOu+gvbO98m83jv+QMSNv1E+gAJI14khL8XqMqi3HFJTG8YHn8/OXXRl5hR0uO/VtPaGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=2g9KvwvO; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="2g9KvwvO"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 84FB74E428D5
	for <linux-rtc@vger.kernel.org>; Fri,  3 Apr 2026 16:08:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5B832603C1;
	Fri,  3 Apr 2026 16:08:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BAD3C10450102;
	Fri,  3 Apr 2026 18:08:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775232532; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=3sosAf2CIreDifBzoBtUND8r8whEpjE837Vg8w5UNAs=;
	b=2g9KvwvOh0FHmcThXXCb3uSxSvi0WgZs1/82Acntg5d0PfoIYfa2p2ot30UA0koKTyRZ7G
	Kke29Vq48WUKxYbyhMN9tgQ0s8sQipfFuejKF3bjbmZ2Q2AHOc5ZeVyHlkP3yzh3/XA8rb
	TaZp17eZY2aB8OMxb5mLUDJomPjKE3OXKWr4a1hMUUivHa01rI5+4ym+Hsi3NtzuNEu3gf
	KUau9gd/qNwkt1OJyhIQNIpNhaMve5MYOy+ZSW9moyxzjJugHTx4IKYfStfd1Z5zPmUenr
	ekq6aBykpD20jbAr88bDo3rJRgHz7zbUcNvwgtujqNBd+V9+5V7iuZCZ12mSew==
Date: Fri, 3 Apr 2026 18:08:50 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: cmos: Remove redundant include of linux/acpi.h
Message-ID: <177523251878.1559844.5790356423146303538.b4-ty@b4>
References: <20260304023533.503066-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304023533.503066-1-nichen@iscas.ac.cn>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 04 Mar 2026 10:35:33 +0800, Chen Ni wrote:
> The header file <linux/acpi.h> is already included globally at the top
> of the file. The second inclusion inside the #ifdef CONFIG_ACPI block is
> redundant because the header uses include guards to prevent multiple
> inclusions.
> 
> Remove the duplicate line to clean up the code and slightly reduce
> preprocessing overhead.
> 
> [...]

Applied, thanks!

[1/1] rtc: cmos: Remove redundant include of linux/acpi.h
      https://git.kernel.org/abelloni/c/a33bf4b6adf7

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
