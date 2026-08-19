Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2981648662F
	for <linux-rtc@vger.kernel.org>; Wed, 19 Aug 2026 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787157058; cv=none; b=Fl/u8i7vpHMzcEV7UjfcOFsgD98Rd6nnwmyly151r+ymJmupFhPqV/rVhzHA04APg9OUOrrrhPYnh5iDwCfpJK5DaAXxPSCtg5iwc6fCrhJTgr9q7qrGo2BJ9YnLbpTJNPBZjfj4Qa63DRuEq0vnkT03/TM0D/zUtuABViazQ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787157058; c=relaxed/simple;
	bh=8lW/vz+IWe85/p/9eKyrTJxG7G/VjF7xaChnZYfiSpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYldp9wmZ0vebU+FfL2e+gMFikGkFSLtsYZmH06h55IyR9Yb8rKWQcGmpS21LcYCSsrz/wxRAZaq7StjJKwfWh1qgZ34f2P68jfqG7WKuqm1RZreBzq23gjm48+9AsI8ahSPKkrSfVTE30FFpD2X5dH6L2H7lTWvPqpjGwy4Rj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SAUwiGiF; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SAUwiGiF"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9FFA41A173C;
	Wed, 19 Aug 2026 16:30:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 73B835FF42;
	Wed, 19 Aug 2026 16:30:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B5BBE11C7590E;
	Wed, 19 Aug 2026 18:30:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787157050; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=J3xq+poQ7DrCsZFFx/PFFj8t8tD/+36W/+yKuLEhob8=;
	b=SAUwiGiFS2urYtAi52iN+jmjozA1hoC6CIl4mCyNxRB3rYiiILTdKPvw12QkVG6IO5W/t5
	Hay1EBlN+FlD1MVDuqUh63k+p9NoqMdPAxj+bRtK3iRW0beoVhpj8berbRjh9EfwxlhuGp
	K//jyx/u8pr8+vGOezIbWOJzuAAWBh1wWOXCW2aTeCsod0S/6Mp0bxCCtUWFXI7lioQqDn
	NS9pKo/0izUdpOktltO+ZAlLxFItw/6UzbS8IYVQLFVPONyn2FIujusjUIb9KAToepRwhD
	xyCfNFm83GNq9tliX9lWLjg922/TvrYHba7wnO0/rNXGU8tAPEZmr47v2qIExA==
Date: Wed, 19 Aug 2026 18:30:48 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: s32g: add missing MODULE_DEVICE_TABLE()
Message-ID: <178715693837.130787.12737079831199612183.b4-ty@b4>
References: <20260704122003.70108-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704122003.70108-1-pengpeng@iscas.ac.cn>
X-Last-TLS-Session-Version: TLSv1.3

On Sat, 04 Jul 2026 20:20:03 +0800, Pengpeng Hou wrote:
> The driver has an OF match table wired to .of_match_table, but does
> not export the table with MODULE_DEVICE_TABLE().
> 
> Add the missing MODULE_DEVICE_TABLE(of, ...) entry so module alias
> information is generated for OF based module autoloading.
> 
> This is a source-level fix.  It does not claim dynamic hardware
> reproduction; the evidence is the driver-owned match table, its use by
> the platform driver, and the missing module alias publication.
> 
> [...]

Applied, thanks!

[1/1] rtc: s32g: add missing MODULE_DEVICE_TABLE()
      https://git.kernel.org/abelloni/c/f1daef283404

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
