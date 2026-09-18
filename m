Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4BF37C0E6;
	Fri, 18 Sep 2026 11:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789731876; cv=none; b=OcIaa6vLgD4YV16hphy5cZTz4iKvo0dMklKrfb9EAy6vQxU4qEBvpvLclFsx69FSZMf/AWdSH/ctoSiJ2oHHzGBLmQShYi0Du5ri+U79a8ad93YEa2A5LruFyBw4eZIh0C1GwLOrubAcRFEYoFXp2c9bWT3wHAbpU9ZmUiMcPYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789731876; c=relaxed/simple;
	bh=gCjeBpViW1+ONn6sEXD1buuFG0vfLXlo4IM/MDM5ezY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ko226kgHlAQEGsE4A2i4iMlrnewXds4Y2CZTzUP1rTA06qPbcoKBHP+UZLvDDVN9VVW9VXYR5wMAKAmK0Vbg0hIPzn1+mgmYIuZhfBJWo2iO2+n+ECAydauNqAOwTXcJJe61aabQpSpX+NwhSF0tKAusAQqBC/RWFDsEPJhSFZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yi6tIWX4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yi6tIWX4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFBD1F000FF;
	Fri, 18 Sep 2026 11:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789731874;
	bh=XX2yD+8wURMhJe8OMHAj9LszXZhB6LGH5KwBAjhAx08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Yi6tIWX4ay20JVGOp4RLYzDscKJEdk1Py/RsefQ9uBr94B4lTauReE6wK/Slixycg
	 IXBKwvOzgdL7WOkZ4zT1BGHkKqnJ9Xvy8oGNVel18E1h6DTkQsGBBDFDXd1mQ5fjEH
	 0nAHLupBTuwp0pjWhuzKoeHA5hW0DKjBGxN3xh3mjmrS0qW7DMbMNYvrg8BAJf5sJ5
	 GbHLa1utAJdX/Jyw6O6sKUKbBxfXs+1zdHv4k/gCaO48Ff3bKUF5DnK9tUFvfIyPKh
	 gvV9ZrOLjEUVdNy7NRX1c/5qeH+wvZc+ouAGVgbizdcrC3FGVZwLwhL0+E9APj+59A
	 yPC7/Nwi/Yh7Q==
Date: Fri, 18 Sep 2026 13:44:30 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sander Speetjens <sander.speetjens@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Jonathan Bell <jonathan@raspberrypi.com>, Stefan Wahren <wahrenst@gmx.net>, linux-rtc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/2] dt-bindings: rtc: Add property for Raspberry Pi 5
 RTC
Message-ID: <20260918-steadfast-unselfish-loris-996d7d@quoll>
References: <20260917135841.841680-1-sander.speetjens@gmail.com>
 <20260917135841.841680-2-sander.speetjens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260917135841.841680-2-sander.speetjens@gmail.com>

On Thu, Sep 17, 2026 at 03:58:40PM +0200, Sander Speetjens wrote:
> Add trickle-voltage-millivolt property for the Raspberry Pi 5 RTC.

Why? Describe the hardware, the need, not the diff.

> 
> V2 -> V3: Fixed the firmware property naming


Changelog goes to the changelog area (under ---). Please look at other
patches how they do it if you are uncertain.

Best regards,
Krzysztof

