Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CFE372B57;
	Fri,  3 Apr 2026 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775228267; cv=none; b=MY33YBgloytThR+fnJPoFFXFDBoPd/4at00THjG54+8KIJ0QELUBYaHkJkZR85eHkABjoIJHG7mwJVbR6bcJC3z8U7zUuLE4PHSZrZyxQ8kqOT7CbxXR+dMHF7D2WhoJQ8daJK+uVesuWkpH7r6fO65XvusMCwC4JW72RdFq3SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775228267; c=relaxed/simple;
	bh=3/niLYIzXKNN+7WXyba8rYAbmmDfrBLZglBTW+BpYLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/aVbWyyml0nNfwoewBnKS53yK6giSQadoQ9sOLjw29cgcQ/AxPrlrR63ZCj2fn3IOs2opQnbe2CCOvyIOBqHwfqw2ODQRIDzXqck2CTiltrzQsJo2Rt4GW1qHBATZ2hQieW2jC+ieg0a7D5nIHYxKDZEEiLjFlBJDFlxW9BjNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mAjM/85e; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mAjM/85e"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A2549C59F5E;
	Fri,  3 Apr 2026 14:58:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AB35A603C1;
	Fri,  3 Apr 2026 14:57:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 30E89104500E1;
	Fri,  3 Apr 2026 16:57:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775228263; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=UA+mdSe0ccvugAmWac/vdBqHTrHlHxa8Afp9m9KG/48=;
	b=mAjM/85e+0tVozCGKNdG5M/GmJDTIEPMFWCExjKU4eOkYQ8KcCXVveAOdKH6yDzRWdE/Cc
	XoSFGvpzu3PnIacUMWh+YGKJyp5IaZHnXjnxbpCZexL4bVfYu5VVBjWna6kmcfT02DL7+m
	JAUD2XvK/LAr8rg+BgKyO87vIBtwyM5JB+U3LOwPvs7W91eUN6niHftGfYJcwQT+59aw9o
	t59A+rICLGWlmRh3nWVZ3CeTgWSNOwZq3AcA1DPdx8de8ajVefV0CL5tCPPBSc6meBrAs7
	a0nSUvGq+aZ8E/860Ox1bTmXFJw4D4iWskTaGRKZSpqRBmy1i9XXjPPx+8AWnw==
Date: Fri, 3 Apr 2026 16:57:41 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Anushka Badhe <anushkabadhe@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, dsd@laptop.org,
	krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH v2] dt-bindings: rtc: add olpc,xo1-rtc to trivial-rtc
Message-ID: <177522825137.1506847.7039045820186398050.b4-ty@b4>
References: <20260325093003.44051-1-anushkabadhe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325093003.44051-1-anushkabadhe@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 25 Mar 2026 15:00:03 +0530, Anushka Badhe wrote:
> Add the OLPC XO-1 RTC compatible string to the trivial-rtc schema
> instead of creating a standalone binding file, as it only requires
> a compatible property with no additional configuration.

Applied, thanks!

[1/1] dt-bindings: rtc: add olpc,xo1-rtc to trivial-rtc
      https://git.kernel.org/abelloni/c/d1b091aaba8c

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
