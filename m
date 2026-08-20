Received: from cpanel10.indieserve.net (cpanel10.indieserve.net [199.212.143.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C01C40B102;
	Thu, 20 Aug 2026 10:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.212.143.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787220238; cv=none; b=cD6xBSvfYPsW8d+utVCBHhHeOAmQs2eDyISCxqxXEr6jigW57ffPVWt25t+Wt0MdYr9uchOi1tf1V+xHJXdXBCByqgCsG//zLY209SWL/ifYCT2pRrD678pAWVmoy7oyIkPFsM4JPo8HBsZGyBysxi12SfyGELemTwFHXfYX5Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787220238; c=relaxed/simple;
	bh=YfWkLiaz9ZHV2GrHzLsP9+QGQNner8OTb18Wa83n6NE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=INVlXDx08PytJ2iJZbII5QiRhGSEOo+XIjacNOGuon1fQ5ch3HcPbBlchD8miqFleDVdQ0xSVYf4cRQFnHn99a/cqFHXss7yGzWWe8+5KOSYIb0dIotZhiVwYuYOwOvVmN0QVc08kNYIoSXCJozPbqTf1FjLttvu12F2d16Knl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crashcourse.ca; spf=pass smtp.mailfrom=crashcourse.ca; dkim=pass (2048-bit key) header.d=crashcourse.ca header.i=@crashcourse.ca header.b=YDONABm+; arc=none smtp.client-ip=199.212.143.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crashcourse.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crashcourse.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crashcourse.ca header.i=@crashcourse.ca header.b="YDONABm+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
	Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wvqozRFiykwItQSaDE5EmngGOaM91IggubIq/e4GQB8=; b=YDONABm+c3b0mfHeWroEfYN5ho
	NLo0kQK/UfPlEZr7Xsq+1lb0ToSJ5DkoUyTipG1blzXI1ZTskhXLGw+soBodsCPvuHC16DqtmabiX
	VqUF8xzIfRLplSGrhF+UWFut2t4fsm9rr+mYKNTzFAimjZGEO8WOedUz17OoRwdYGi3jYIZZb3uAo
	ILS0IwlMffO2U0oVSrscaKV83qXgdgDkvpLmB9ahTN/M/w838xoU9BnrbzePDSbd1sGMOdb/vYdQM
	cOP8k56Pw9fjLGdEFq9oItrp0/mpqZngoUGnnCseHjYUSJLUgX4Kwxt+J0eFXp5IXx9FfVNKe7Cji
	ygxc8Tbw==;
Received: from pool-174-114-114-5.cpe.net.cable.rogers.com ([174.114.114.5]:57000 helo=sheena)
	by cpanel10.indieserve.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1wwzGo-0000000GkRY-3uE3;
	Thu, 20 Aug 2026 05:41:11 -0400
Date: Thu, 20 Aug 2026 05:39:29 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: Markus Elfring <Markus.Elfring@web.de>
cc: 1298662399@qq.com, linux-rtc@vger.kernel.org, 
    Alexandre Belloni <alexandre.belloni@bootlin.com>, 
    LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] rtc: rtc-pic32: handle clock enable failure
In-Reply-To: <1f67f9ed-3e84-426e-a671-4baa3c0d6173@web.de>
Message-ID: <66852c50-85fc-f5ff-46a4-5bd65e087c9d@crashcourse.ca>
References: <tencent_7FCEEF77654C7D6B110DE49D2E98531A2006@qq.com> <1f67f9ed-3e84-426e-a671-4baa3c0d6173@web.de>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1731101118-1787218794=:3239356"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel10.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel10.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel10.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1731101118-1787218794=:3239356
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 20 Aug 2026, Markus Elfring wrote:

> …
> > Check early clk_prepare_enable(pdata->clk) return in pic32_rtc_probe.
>
> I find such a wording approach improvable.
> How do you think about to add any tags (like “Fixes” and “Cc”) accordingly?

  How many times are you going to ask this same question?

rday
--8323329-1731101118-1787218794=:3239356--
