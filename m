Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A664428461
	for <linux-rtc@vger.kernel.org>; Fri, 22 May 2026 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459424; cv=none; b=D5/bfAr6rwrv15z7l8jVehcHN5oOf2nixDFaMG7M7dSa30cw9wUz20MbmTztAv2PFBr0tDNwXwFdoTdqHa6wKGy3vRMc13GgFfR2vUQe3bxfwG9vl+WcF563AQ41xzg5f0KzpKpqth+4JYm6g+FgaMqOb8uNYmyX3Jyf6w4KmO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459424; c=relaxed/simple;
	bh=Sg8+H4uZNumNdUjBLaR9HtwFit20JusnwC4GFitpxtE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 In-Reply-To; b=Qzm+BN1YhpKWrOxnVIXbFuUK3hwGLDPV7wqHlzEx4SAZHGW+Abn1XD99Py/8/l9kCP7SOuaaHVFQK+FWTv3vg3iB3zggkgBwCpwC3Fcc0fYLDL5DzNHf9TJ+msfCXA+1S5qJJOl8rKrCCX/bHJKOgEK6f3VjxuxPCigig9LCl7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zqzdeH2m; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zqzdeH2m"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A506B4E42D29
	for <linux-rtc@vger.kernel.org>; Fri, 22 May 2026 14:16:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5F9F16003C;
	Fri, 22 May 2026 14:16:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3E22C10811499;
	Fri, 22 May 2026 16:16:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779459412; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to;
	bh=Sg8+H4uZNumNdUjBLaR9HtwFit20JusnwC4GFitpxtE=;
	b=zqzdeH2m70ky5xLqpABf0/diKCldIYjcHA7j02O2coJ9rVWrJpqIHRO8Ji8KWDIggxYfxV
	guUhmQ0FInO+RJgC/a6eH8L3Wf3Sa5xJJttYTD+HcKUAi1tqcf7AFL8GmcfDYrjVy7vDW7
	+tVCTdsAyCiIuDDUdKwtNMVzFDnI/Q3FbgXd7TI+vbjCStDhNnbA1aphOlM8A07oldPXF5
	Gd1G5wnnAnsT0BX24xSVrfqkdVCp0x7FM+yqCM5iiHz2qnQW8dCeWFSmyV4jWYZkc4EeX2
	aRxUSZR6anLytmEbzyTB+DZRg8aKaCVCewL4wOY5rOnroJIoyPHdavTpAKRmNA==
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 22 May 2026 16:16:51 +0200
Message-Id: <DIP9PS55JT5B.199C2HJ65GJH9@bootlin.com>
Cc: <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
 <linux-rtc@vger.kernel.org>
Subject: Re: [PATCH] rtc: pcf2127: clear the PWRMNG bits for pcf2131
From: "Thomas Bonnefille" <thomas.bonnefille@bootlin.com>
To: <alessandro.dichiara@se.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
In-Reply-To: <20251210-rtc-pcf2131-clear-pwrmng-bits-v1-1-407c1c573726@se.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello,

Has there been any update on this patch?
I'm currently interested in it and would be happy to continue the
upstreaming process if needed.

Best regards,
Thomas
