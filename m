Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E50D3B47D0;
	Fri,  2 Oct 2026 09:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790934818; cv=none; b=e07xlFwK4JbnbbwaIQeLdX0e66MV+j3hQ3rowh5E0zQS3/9m/dBujWN0IZYCxbZH9o4L2lYzHmOQyZIBk10Nx6dWFR177rnWz7eLCVOs9P+x8zmaqVyLThLn0P8nMJePgpm0S3bZJAhg1x0jLvB6UEGJOPXFU2unMxQA7WHL840=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790934818; c=relaxed/simple;
	bh=rSJtrn+mxA5xF6RWaqUYkGC/l6fyaETthhcXNAnSpSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPO8nbdtaydSLx2b6wnnMGfmcVr3FYvBF5YfrahkLJYvoHohvZR6WV4pQrUEsMfYi2eXgp9rVWWObiMk+wfRZGA1LgTJ7K6lqENbYb1hspVeJc0oK+0CQYYZ6Aw3K5ObZDC0w3XSUnyVqxpce629LptWCV/7EP+JgKO5qMRRflk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qjqe23iO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qjqe23iO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965391F000FF;
	Fri,  2 Oct 2026 09:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790934816;
	bh=sfnfzWmm2BDCyb+S8lJSQc0AkVFKWdTNICDV/Hi2Ki4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qjqe23iOSVU285nzC63eIKl4jZp1VpzdZd4v2d1vx4o0ao/QZ/tt8an6Lcm7L7yVd
	 6WRbVsRVVqusz3SGbqJp7rf9W3wiIXXPS98fvKU9T4+fgwbdzLAI0/7tQ+UWzwLQRr
	 3LvEjKU6lwZeMUT9aGyli5ZTUUUrcaw4CWw5GAcB8n1Mguwej9xl2bldBbd90BND3Z
	 xe6ChjszAv6Pb4690hittPC1WE2mDIo6sIndUgxKGRkRns8TIAOB8/fyGKo19H4tAX
	 L1ZkFQB3T+58T79LPVPkS7/ERyDoEmeuwRMmOy8COt0UNX4bGguA4LclPR/YjsG75R
	 CKN9K2ZVkC7nw==
Date: Fri, 2 Oct 2026 11:53:33 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sander Speetjens <sander.speetjens@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Jonathan Bell <jonathan@raspberrypi.com>, Stefan Wahren <wahrenst@gmx.net>, linux-rtc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, pbrobinson@gmail.com, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v9 2/3] dt-bindings: rtc: Add property for Raspberry Pi 5
 RTC
Message-ID: <20261002-prompt-sophisticated-sawfly-bb6f04@quoll>
References: <20261001193703.734323-1-sander.speetjens@gmail.com>
 <20261001193703.734323-3-sander.speetjens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261001193703.734323-3-sander.speetjens@gmail.com>

On Thu, Oct 01, 2026 at 09:37:02PM +0200, Sander Speetjens wrote:
> The Raspberry Pi 5 has a built-in RTC that can be battery-backed
> via the VBAT pin. When a rechargeable coin cell is used, the
> hardware requires a trickle-charge voltage to keep the battery
> topped up.
> 
> Expose the trickle-voltage-millivolt DT property so the driver can
> program the correct charge voltage for board specific configurations with
> the attached battery.

Commit msg could explain that you do not reference rtc.yaml due to node
naming rule.

> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Sander Speetjens <sander.speetjens@gmail.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

